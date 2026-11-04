function newcpp
    if test (count $argv) -ne 1
        echo "usage: newcpp NAME"
        return 1
    end
    set name $argv[1]
    set dest ~/dev/cpp/$name

    if test -e $dest
        echo "already exists: $dest"
        return 1
    end

    cp -r ~/dev/cpp/_template $dest
    or return 1
    cd $dest
    or return 1

    sed -i '' "s/@NAME@/$name/g" CMakeLists.txt

    git init -q
    git add .
    git commit -qm "initial commit"

    cmake --preset debug
    and cmake --build --preset debug
    and echo "ok: ./build/debug/$name"
end
