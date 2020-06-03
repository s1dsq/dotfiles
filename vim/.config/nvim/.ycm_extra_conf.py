# This file is NOT licensed under the GPLv3, which is the license for the rest
# of YouCompleteMe.
#
# Here's the license text for this file:
#
# This is free and unencumbered software released into the public domain.
#
# Anyone is free to copy, modify, publish, use, compile, sell, or
# distribute this software, either in source code form or as a compiled
# binary, for any purpose, commercial or non-commercial, and by any
# means.
#
# In jurisdictions that recognize copyright laws, the author or authors
# of this software dedicate any and all copyright interest in the
# software to the public domain. We make this dedication for the benefit
# of the public at large and to the detriment of our heirs and
# successors. We intend this dedication to be an overt act of
# relinquishment in perpetuity of all present and future rights to this
# software under copyright law.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#
# For more information, please refer to <http://unlicense.org/>

import os
import os.path
import fnmatch
import logging
import ycm_core
import re

BASE_FLAGS = [
    '-Wall',
    '-pedantic',
    '-Wshadow',
    '-Wformat=2',
    '-Wfloat-equal',
    '-Wlogical-op',
    '-DDEBUG',
    '-std=c++17',
    '-x',
    'c++',
    '-isystem', '/usr/local/include/'
]

SOURCE_EXTENSIONS = [
    '.cpp',
    '.cxx',
    '.cc',
    '.c',
    '.m',
    '.mm',
]

SOURCE_DIRECTORIES = [
    'src',
    'lib',
]

HEADER_EXTENSIONS = [
    '.h',
    '.hxx',
    '.hpp',
    '.hh',
]

HEADER_DIRECTORIES = [
    'include',
]

BUILD_DIRECTORY = 'build';

FLAG_FILES = [
    'compile_flags.txt',
    '.clang_complete',
]

def IsHeaderFile(filename):
    extension = os.path.splitext(filename)[1]
    return extension in HEADER_EXTENSIONS

def FindNearest(path, target, build_folder=None):
    candidate = os.path.join(path, target)
    if(os.path.isfile(candidate) or os.path.isdir(candidate)):
        logging.info("Found nearest " + target + " at " + candidate)
        return candidate;

    parent = os.path.dirname(os.path.abspath(path));
    if(parent == path):
        raise RuntimeError("Could not find " + target);

    if(build_folder):
        candidate = os.path.join(parent, build_folder, target)
        if(os.path.isfile(candidate) or os.path.isdir(candidate)):
            logging.info("Found nearest " + target + " in build folder at " + candidate)
            return candidate;

    return FindNearest(parent, target, build_folder)

def CompilationDatabaseToFlags(database, filename):
    compilation_info = database.GetCompilationInfoForFile(filename)
    if compilation_info.compiler_flags_:
        return {
            'flags': compilation_info.compiler_flags_,
            'include_paths_relative_to_dir': compilation_info.compiler_working_dir_,
            'override_filename': filename,
        }
    return None

def GetCompilationInfoForFile(database, filename):
    flags = CompilationDatabaseToFlags(database, filename)
    if flags:
        return flags

    if IsHeaderFile(filename):
        basename = os.path.splitext(filename)[0]
        for extension in SOURCE_EXTENSIONS:
            # Get info from the source files by replacing the extension.
            replacement_file = basename + extension
            if os.path.exists(replacement_file):
                flags = CompilationDatabaseToFlags(database, replacement_file)
                if flags:
                    return flags
            # If that wasn't successful, try replacing possible header directory with possible source directories.
            for header_dir in HEADER_DIRECTORIES:
                for source_dir in SOURCE_DIRECTORIES:
                    src_file = replacement_file.replace(header_dir, source_dir)
                    if os.path.exists(src_file):
                        flags = CompilationDatabaseToFlags(database, src_file)
                        if flags:
                            return flags

    return None

def FlagsFromClangComplete(root):
    for filename in FLAG_FILES:
        try:
            clang_complete_path = FindNearest(root, filename)
            clang_complete_flags = open(clang_complete_path, 'r').read().splitlines()
            return {
                'flags': clang_complete_flags,
                'include_paths_relative_to_dir': os.path.dirname(clang_complete_path),
            }
        except Exception:
            pass
    return None

def FlagsFromInclude(root):
    try:
        include_path = FindNearest(root, 'include')
        flags = BASE_FLAGS
        for dirroot, dirnames, filenames in os.walk(include_path):
            for dir_path in dirnames:
                real_path = os.path.join(dirroot, dir_path)
                flags = flags + ["-I" + real_path]
        return { 'flags': flags }
    except Exception:
        pass

    return None

def FlagsFromCompilationDatabase(root, filename):
    try:
        # Last argument of next function is the name of the build folder for
        # out of source projects
        compilation_db_path = FindNearest(root, 'compile_commands.json', BUILD_DIRECTORY)
        compilation_db_dir = os.path.dirname(compilation_db_path)
        logging.info("Set compilation database directory to " + compilation_db_dir)
        compilation_db =  ycm_core.CompilationDatabase(compilation_db_dir)
        if not compilation_db:
            logging.info("Compilation database file found but unable to load")
            return None
        compilation_info = GetCompilationInfoForFile(compilation_db, filename)
        if not compilation_info:
            logging.info("No compilation info for " + filename + " in compilation database")
            return None
        return compilation_info
    except Exception:
        return None

def FlagsForCfamily(**kwargs):
    filename = kwargs['filename']
    root = os.path.realpath(filename);

    compilation_db_flags = FlagsFromCompilationDatabase(root, filename)
    if compilation_db_flags:
        return compilation_db_flags

    clang_flags = FlagsFromClangComplete(root)
    if clang_flags:
        return clang_flags

    include_flags = FlagsFromInclude(root)
    if include_flags:
        return include_flags

    return { 'flags': BASE_FLAGS, }

def Settings(**kwargs):
    language = kwargs[ 'language' ]
    if language == 'cfamily':
        return FlagsForCfamily(**kwargs)
    if language == 'python':
        # TODO
        return {}
    return {}
