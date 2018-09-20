var scene = new THREE.Scene();
var camera = new THREE.PerspectiveCamera(75, 1200 / 600, 0.1 / 1000);

var renderer = new THREE.WebGLRenderer();
renderer.setSize(1200, 600);
document.getElementById('canvas').appendChild(renderer.domElement);

var geometry = new THREE.BoxGeometry(5, 5, 0.1);
var texture = new THREE.TextureLoader().load("img/contract.png");
var material = new THREE.MeshBasicMaterial({
    color: 0xffffff,
    map: texture
});
var cube = new THREE.Mesh(geometry, material);
scene.add(cube);

camera.position.z = 10;

var geometry = new THREE.PlaneGeometry(50, 2.5, 32);
var material = new THREE.MeshBasicMaterial({
    color: 0xffffff,
    side: THREE.DoubleSide,
    transparent: true,
    opacity: 0.3
});
var plane = new THREE.Mesh(geometry, material);
plane.position.set(0, 7, 0);
scene.add(plane);

dirLight = new THREE.DirectionalLight(0xffffff);
dirLight.position.set(-1, 0, 1).normalize();
scene.add(dirLight);

scene.fog = new THREE.FogExp2(0x000000, 0.00000025);

function animate() {
    requestAnimationFrame(animate);
    cube.rotation.y += 0.01;
    renderer.render(scene, camera);
}

animate();