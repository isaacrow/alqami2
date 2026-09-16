const fs = require('fs');
const { NodeIO } = require('@gltf-transform/core');
const { KHRONOS_EXTENSIONS } = require('@gltf-transform/extensions');
const draco3d = require('draco3dgltf');

async function checkSize(file) {
    const io = new NodeIO()
        .registerExtensions(KHRONOS_EXTENSIONS)
        .registerDependencies({
            'draco3d.decoder': await draco3d.createDecoderModule()
        });
    const doc = await io.read(file);
    const root = doc.getRoot();
    const meshes = root.listMeshes();
    console.log(file, 'meshes:', meshes.length);
}

checkSize('old-babylonian_cuneiform_tablet_s264.glb');
checkSize('stela_of_hammurabi_replica.glb');
checkSize('bowl.glb');
