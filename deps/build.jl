using BinDeps 

@BinDeps.setup

@linux_only begin
    hdf5 = library_dependency("libhdf5")
    provides(AptGet, "hdf5-tools", hdf5)
    provides(Yum, "hdf5", hdf5)
    if WORD_SIZE == 32
        provides(Binaries, URI("http://www.hdfgroup.org/ftp/HDF5/current/bin/linux/hdf5-1.8.13-linux-shared.tar.gz"), hdf5, unpacked_dir=Pkg.dir("HDF5/deps/usr/lib/")
    else
        provides(Binaries, URI("http://www.hdfgroup.org/ftp/HDF5/current/bin/linux-x86_64/hdf5-1.8.13-linux-x86_64-shared.tar.gz"), hdf5, unpacked_dir=Pkg.dir("HDF5/deps/usr/lib/")
    end
end

@windows_only begin
    hdf5 = library_dependency("hdf5")

    const OS_ARCH = WORD_SIZE == 64 ? "x86_64" : "x86"

    if WORD_SIZE == 32
            provides(Binaries,URI("https://ia601003.us.archive.org/29/items/julialang/windows/hdf5-1.8-win32.7z"),hdf5,os = :Windows)
    else
            provides(Binaries,URI("https://ia601003.us.archive.org/29/items/julialang/windows/hdf5-1.8-win64.7z"),hdf5,os = :Windows)
    end
    push!(DL_LOAD_PATH, joinpath(Pkg.dir("HDF5/deps/usr/lib/"), OS_ARCH))
end

@osx_only begin
    using Homebrew
    hdf5 = library_dependency("libhdf5")
    provides( Homebrew.HB, "hdf5", hdf5, os = :Darwin )
end

@BinDeps.install
