$:.unshift 'lib/NetApp'
require 'NaServer'


def print_usage
    print("Usage:flexClone.rb <storage> <user> <password> <command> <clone-volname>")
    print(" [<volume>]\n")
    print("<storage>   -- Storage system name\n")
    print("<user>      -- User name\n")
    print("<password>  -- Password\n")
    print("<command>   -- Possible commands are:\n")
    print("  create   - to create a new clone\n")
    print("  delete   - to destroy a clone\n")
    print("<clone-volname>    -- clone volume name \n")
    print("[<parent-volname] -- name of the parent volume to create the clone. \n")
    exit 
end


args = ARGV.length
if(args < 5)
    print_usage()
end
$storage = ARGV[0]
$user = ARGV[1]
$pw  = ARGV[2]
$command = ARGV[3]
$clone_name = ARGV[4]
$parent_vol = nil
if(args > 5)
    $parent_vol = ARGV[5]
end



def create_flexclone()
    clone_in = NaElement.new("volume-clone-create")
    clone_in.child_add_string("parent-volume", $parent_vol)
    clone_in.child_add_string("volume", $clone_name)
    # Invoke volume-clone-create API
    out = $s.invoke_elem(clone_in)
    if(out.results_status() == "failed")
        print(out.results_reason() + "\n")
        exit
    end
end

def delete_flexclone()
    clone_destroy_in = NaElement.new("volume-destroy")
    clone_destroy_in.child_add_string("name", $clone_name)
    # Invoke volume-destroy API
    out = $s.invoke_elem(clone_destroy_in)
    if(out.results_status() == "failed")
        print(out.results_reason() + "\n")
        exit
    end
end

def mount_flexclone()
    clone_mount_in = NaElement.new("volume-mount")
    clone_mount_in.child_add_string("volume-name", $clone_name)
    clone_mount_in.child_add_string("export-policy-override", "true")
    clone_mount_in.child_add_string("junction-path", "/"+$clone_name)
    # Invoke volume-destroy API
    out = $s.invoke_elem(clone_mount_in)
    if(out.results_status() == "failed")
        print(out.results_reason() + "\n")
        exit
    end
end

def unmount_flexclone()
    clone_unmount_in = NaElement.new("volume-unmount")
    clone_unmount_in.child_add_string("volume-name", $clone_name)
    out = $s.invoke_elem(clone_unmount_in)
    if(out.results_status() == "failed")
        print(out.results_reason() + "\n")
        exit
    end
end

def volume_offline()
    clone_offline_in = NaElement.new("volume-offline")
    clone_offline_in.child_add_string("name", $clone_name)
    # Invoke volume-destroy API
    out = $s.invoke_elem(clone_offline_in)
    if(out.results_status() == "failed")
        print(out.results_reason() + "\n")
        exit
    end
end
	

def main
    if(not (($command == "create") or ($command == "delete")))
        print($command+" is not a valid command\n")
        print_usage()
    end
    if (($command == "create") and ($parent_vol == nil))
        print($command+" operation requires <parent-volname>\n")
        print("Usage: flexclone.py <storage> <user> <password>"+$command+" <clone-volname> <parent-volname>\n")
        exit 
    end 
    $s = NaServer.new($storage, 1, 3)
    $s.set_admin_user($user, $pw)
    if($command == "create")
        create_flexclone()
        mount_flexclone()
    elsif($command == "delete")
        unmount_flexclone()
        volume_offline()
        delete_flexclone()
    else 
        print("Invalid operation\n")
        print_usage()
    end
end


main()

