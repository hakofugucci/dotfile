function newcpp --description 'Create a C++ project from the template'
    if test (count $argv) -ne 1
        echo "usage: newcpp NAME"
        return 1
    end

    set -l name $argv[1]
    if not string match -rq '^[A-Za-z0-9_-]+$' -- $name
        echo "invalid name: use letters, digits, _ and -"
        return 1
    end

    set -l tpl ~/.config/fish/templates/cpp
    set -l dest ~/dev/cpp/$name

    if not test -d $tpl
        echo "template not found: $tpl"
        return 1
    end
    if test -e $dest
        echo "already exists: $dest"
        return 1
    end

    cp -r $tpl $dest
    or return 1
    cd $dest
    or return 1

    set -l tmp (mktemp)
    string replace -a '@NAME@' $name < CMakeLists.txt > $tmp
    and mv $tmp CMakeLists.txt
    or return 1

    git init -q
    git add .
    git commit -qm "initial commit"

    cmake --preset debug
    and cmake --build --preset debug
    and echo "ok: ./build/debug/$name"
end
