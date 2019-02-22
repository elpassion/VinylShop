#!/usr/local/bin python3

from pbxproj import XcodeProject
import subprocess
import sys
import yaml
import os

def main():
    if len(sys.argv) != 4:
        print("Incorrect usage! {0} <xcodeproj_path> <target_name> <swiftlint_reference_file>")
        sys.exit(-1)

    xcodeproj_path = sys.argv[1]
    target_name = sys.argv[2]
    swiftlint_path = sys.argv[3]

    if os.path.isfile('.swiftlint.yml'):
        print("Script failed, found existing .swiftlint.yml file!")
        sys.exit(-1)

    with open(swiftlint_path, 'r') as sources:
        sources_config = yaml.load(sources)

        project = XcodeProject.load(os.path.join(xcodeproj_path, 'project.pbxproj'))
        files = list_files(project, target_name)

        with open('.swiftlint.yml', 'w') as output:
            sources_config['included'] = files
            yaml.dump(sources_config, output, default_flow_style=False, allow_unicode=True)

            process = subprocess.run(["swiftlint"])

            try:
                os.remove('.swiftlint.yml')
            except OSError:
                print("Cleanup failed, could not remove .swiftlint.yml file")

    sys.exit(process.returncode)

def list_files(project, target_name):
    target = project.get_target_by_name('VinylShop')

    if not target:
        return []

    files = []

    for build_phase_id in target.buildPhases:
        build_phase = project.objects[build_phase_id]
        if build_phase.isa == 'PBXSourcesBuildPhase':
            for build_file_id in build_phase.files:
                build_file = project.objects[build_file_id]
                file_ref = project.objects[build_file.fileRef]
                files.append(full_path(project, file_ref))

    return files

def full_path(project, file_ref):
    folder = None

    if file_ref.sourceTree == '<group>':
        parent = parent_group(project, file_ref)

        if parent:
            folder = full_path(project, parent)
    elif file_ref.sourceTree == '<absolute>':
        folder = '/'

    folder = folder if folder else ''

    if 'path' in file_ref:
        return os.path.join(folder, file_ref['path'])
    else:
        return folder

def parent_group(project, file_ref):
    for group in project.objects.get_objects_in_section('PBXGroup'):
        if group.has_child(file_ref.get_id()):
            return group

if __name__ == '__main__':
    main()