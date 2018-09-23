var scene = new THREE.Scene();
var camera = new THREE.PerspectiveCamera(75, 1200 / 600, 0.1 / 1000);

var controls = new THREE.TrackballControls(camera);
controls.rotateSpeed = 1.0;
controls.zoomSpeed = 1.2;
controls.panSpeed = 0.8;
controls.noZoom = false;
controls.noPan = false;
controls.staticMoving = true;
controls.dynamicDampingFactor = 0.3;

//setup renderer
var renderer = new THREE.WebGLRenderer();
renderer.setSize(1200, 600);
document.getElementById('canvas').appendChild(renderer.domElement);

//contract spinning model
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

function animate() {
    requestAnimationFrame(animate);
    //cube.rotation.y += 0.01;
    renderer.render(scene, camera);
}

animate();