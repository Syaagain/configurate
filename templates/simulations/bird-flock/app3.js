// Szene, Kamera, Renderer
const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera(75, window.innerWidth/window.innerHeight, 0.1, 1000);
const renderer = new THREE.WebGLRenderer({antialias: true});
renderer.setSize(window.innerWidth, window.innerHeight);
renderer.setClearColor(0x000011);
document.body.appendChild(renderer.domElement);

camera.position.set(0, 50, 90);
camera.lookAt(0, 0, 0);

// Szenen-Grenzen definieren
const bounds = {
    x: 80,
    y: 60,
    z: 90
};

// Hilfsfunktionen
function lerp(a, b, t) {
    return a + (b - a) * t;
}

function lerpVector3(v1, v2, t) {
    return new THREE.Vector3(
        lerp(v1.x, v2.x, t),
        lerp(v1.y, v2.y, t),
        lerp(v1.z, v2.z, t)
    );
}



// Sichtkegel-Funktion (Field of View) - vereinfacht
function isInFieldOfView(bird, other) {
    if (bird.velocity.length() < 0.1) return true;
    
    const toOther = new THREE.Vector3().subVectors(other.position, bird.position);
    const forward = bird.velocity.clone().normalize();
    
    const dot = forward.dot(toOther.normalize());
    return dot > 0.3; // Etwa 70° FOV
}

// Schwarm 1: Weiße Papierflieger
const birdCount1 = 50;
const birds1 = [];
const birdGeometry1 = createPaperPlaneGeometry(1.2);
const birdMaterial1 = new THREE.MeshBasicMaterial({
    color: 0x2d4ea2,
    side: THREE.DoubleSide
});

function createPaperPlaneGeometry(scale = 1) {
    const geometry = new THREE.BufferGeometry();

    const vertices = new Float32Array([
        // Spitze vorne (Nase)
        0, 0, 3 * scale,

        // Linke Flügelspitze oben (nach oben gezogen)
        -2.5 * scale, 0.7 * scale, -1 * scale,

        // Linke Flügelansatz vorne (unten)
        -1.2 * scale, -0.2 * scale, 0.5 * scale,

        // Linke Flügelansatz hinten (unten)
        -2 * scale, -0.5 * scale, -1.5 * scale,

        // Körper hinten unten (Körperbasis)
        0, -0.6 * scale, -1.7 * scale,

        // Rechte Flügelansatz hinten (unten)
        2 * scale, -0.5 * scale, -1.5 * scale,

        // Rechte Flügelansatz vorne (unten)
        1.2 * scale, -0.2 * scale, 0.5 * scale,

        // Rechte Flügelspitze oben (nach oben gezogen)
        2.5 * scale, 0.7 * scale, -1 * scale,

        // Rücken oben (leicht nach hinten)
        0, 0.6 * scale, -1.2 * scale,
    ]);

    const indices = [
        0, 1, 2,   // Spitze zu linker Flügel vorne
        2, 1, 3,   // linker Flügel vorne nach hinten
        3, 1, 8,   // linker Flügel nach Rücken oben

        0, 2, 6,   // Spitze zu rechter Flügel vorne
        6, 7, 0,   // rechter Flügel vorne zur Spitze
        7, 8, 0,   // rechter Flügelspitze zu Rücken und Spitze

        3, 4, 5,   // Körper hinten unten quer
        3, 5, 6,   // rechter Flügelansatz hinten

        6, 5, 7,   // rechter Flügelansatz hinten zu Spitze
        5, 4, 8,   // Rücken zum Körper hinten
        8, 7, 5,   // Rücken rechter Flügel hinten
    ];

    geometry.setIndex(indices);
    geometry.setAttribute('position', new THREE.BufferAttribute(vertices, 3));
    geometry.computeVertexNormals();

    return geometry;
}

for (let i = 0; i < birdCount1; i++) {
    const bird = new THREE.Mesh(birdGeometry1, birdMaterial1);
    
    const groupCenter = new THREE.Vector3(
        -50 + (Math.random() - 0.5) * 25,
        -20 + (Math.random() - 0.5) * 25,
        (Math.random() - 0.5) * 30
    );
    
    bird.position.set(
        groupCenter.x + (Math.random() - 0.5) * 12,
        groupCenter.y + (Math.random() - 0.5) * 12,
        groupCenter.z + (Math.random() - 0.5) * 12
    );
    
    bird.velocity = new THREE.Vector3(
        (Math.random() - 0.5) * 2,
        (Math.random() - 0.5) * 2,
        (Math.random() - 0.5) * 2
    );
    bird.velocity.normalize().multiplyScalar(0.6);
    bird.swarm = 1;
    
    // Eigenschaften für verbesserten Algorithmus
    bird.acceleration = new THREE.Vector3();
    bird.maxSpeed = 0.6;
    bird.maxForce = 0.015;
    bird.smoothingFactor = 0.15;
    bird.rotationSpeed = 0.08;
    
    scene.add(bird);
    birds1.push(bird);
}

// Schwarm 2: Hellblaue Papierflieger
const birdCount2 = 50;
const birds2 = [];
const birdGeometry2 = createPaperPlaneGeometry(1.0);
const birdMaterial2 = new THREE.MeshBasicMaterial({
    color: 0x2d4ea2,
    side: THREE.DoubleSide
});

for (let i = 0; i < birdCount2; i++) {
    const bird = new THREE.Mesh(birdGeometry2, birdMaterial2);
    
    const groupCenter = new THREE.Vector3(
        50 + (Math.random() - 0.5) * 25,
        -20 + (Math.random() - 0.5) * 25,
        (Math.random() - 0.5) * 30
    );
    
    bird.position.set(
        groupCenter.x + (Math.random() - 0.5) * 12,
        groupCenter.y + (Math.random() - 0.5) * 12,
        groupCenter.z + (Math.random() - 0.5) * 12
    );
    
    bird.velocity = new THREE.Vector3(
        (Math.random() - 0.5) * 2,
        (Math.random() - 0.5) * 2,
        (Math.random() - 0.5) * 2
    );
    bird.velocity.normalize().multiplyScalar(0.6);
    bird.swarm = 2;
    
    bird.acceleration = new THREE.Vector3();
    bird.maxSpeed = 0.6;
    bird.maxForce = 0.015;
    bird.smoothingFactor = 0.15;
    bird.rotationSpeed = 0.08;
    
    scene.add(bird);
    birds2.push(bird);
}

// Schwarm 3: Gelbe Papierflieger
const birdCount3 = 50;
const birds3 = [];
const birdGeometry3 = createPaperPlaneGeometry(1.4);
const birdMaterial3 = new THREE.MeshBasicMaterial({
    color: 0x2d4ea2,
    side: THREE.DoubleSide
});

for (let i = 0; i < birdCount3; i++) {
    const bird = new THREE.Mesh(birdGeometry3, birdMaterial3);
    
    const groupCenter = new THREE.Vector3(
        (Math.random() - 0.5) * 30,
        30 + (Math.random() - 0.5) * 25,
        (Math.random() - 0.5) * 30
    );
    
    bird.position.set(
        groupCenter.x + (Math.random() - 0.5) * 12,
        groupCenter.y + (Math.random() - 0.5) * 12,
        groupCenter.z + (Math.random() - 0.5) * 12
    );
    
    bird.velocity = new THREE.Vector3(
        (Math.random() - 0.5) * 2,
        (Math.random() - 0.5) * 2,
        (Math.random() - 0.5) * 2
    );
    bird.velocity.normalize().multiplyScalar(0.6);
    bird.swarm = 3;
    
    bird.acceleration = new THREE.Vector3();
    bird.maxSpeed = 0.6;
    bird.maxForce = 0.015;
    bird.smoothingFactor = 0.15;
    bird.rotationSpeed = 0.08;
    
    scene.add(bird);
    birds3.push(bird);
}

const allBirds = [...birds1, ...birds2, ...birds3];

window.addEventListener('resize', () => {
    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();
    renderer.setSize(window.innerWidth, window.innerHeight);
});

// Sanfte Rotation in Flugrichtung
function updateBirdRotation(bird) {
    if (bird.velocity.length() > 0.01) {
        // Yaw (Y-Rotation) basierend auf horizontaler Bewegung
        const targetYaw = Math.atan2(bird.velocity.x, bird.velocity.z);
        let yawDiff = targetYaw - bird.rotation.y;
        if (yawDiff > Math.PI) yawDiff -= 2 * Math.PI;
        if (yawDiff < -Math.PI) yawDiff += 2 * Math.PI;
        bird.rotation.y += yawDiff * bird.rotationSpeed;
        
        // Pitch (X-Rotation) basierend auf vertikaler Bewegung
        const horizontalSpeed = Math.sqrt(bird.velocity.x * bird.velocity.x + bird.velocity.z * bird.velocity.z);
        const targetPitch = -Math.atan2(bird.velocity.y, horizontalSpeed);
        let pitchDiff = targetPitch - bird.rotation.x;
        if (pitchDiff > Math.PI) pitchDiff -= 2 * Math.PI;
        if (pitchDiff < -Math.PI) pitchDiff += 2 * Math.PI;
        bird.rotation.x += pitchDiff * bird.rotationSpeed;
        
        // Leichte Roll-Bewegung bei Kurven
        const rollAmount = bird.velocity.x * 0.3;
        bird.rotation.z = lerp(bird.rotation.z, rollAmount, 0.05);
    }
}

// Alignment - in gleiche Richtung wie Nachbarn fliegen
function align(bird, neighbors) {
    const perceptionRadius = 20;
    let steering = new THREE.Vector3();
    let total = 0;

    for (let i = 0; i < neighbors.length; i++) {
        const other = neighbors[i];
        if (other === bird) continue;
        
        const distance = bird.position.distanceTo(other.position);
        if (other.swarm === bird.swarm && 
            distance < perceptionRadius && distance > 0 &&
            isInFieldOfView(bird, other)) {
            steering.add(other.velocity);
            total++;
        }
    }

    if (total > 0) {
        steering.divideScalar(total);
        steering.normalize();
        steering.multiplyScalar(bird.maxSpeed);
        steering.sub(bird.velocity);
        if (steering.length() > bird.maxForce) {
            steering.normalize().multiplyScalar(bird.maxForce);
        }
    }

    return steering;
}

// Cohesion - zum Zentrum der Nachbarn bewegen
function cohesion(bird, neighbors) {
    const perceptionRadius = 25;
    let steering = new THREE.Vector3();
    let total = 0;

    for (let i = 0; i < neighbors.length; i++) {
        const other = neighbors[i];
        if (other === bird) continue;
        
        const distance = bird.position.distanceTo(other.position);
        if (other.swarm === bird.swarm && 
            distance < perceptionRadius && distance > 0 &&
            isInFieldOfView(bird, other)) {
            steering.add(other.position);
            total++;
        }
    }

    if (total > 0) {
        steering.divideScalar(total);
        steering.sub(bird.position);
        steering.normalize();
        steering.multiplyScalar(bird.maxSpeed);
        steering.sub(bird.velocity);
        if (steering.length() > bird.maxForce) {
            steering.normalize().multiplyScalar(bird.maxForce);
        }
    }

    return steering;
}

// Separation - Abstand zu anderen Vögeln halten
function separation(bird, neighbors) {
    const perceptionRadius = 12;
    let steering = new THREE.Vector3();
    let total = 0;

    for (let i = 0; i < neighbors.length; i++) {
        const other = neighbors[i];
        if (other === bird) continue;
        
        const distance = bird.position.distanceTo(other.position);
        if (distance < perceptionRadius && distance > 0) {
            let diff = new THREE.Vector3().subVectors(bird.position, other.position);
            diff.normalize();
            diff.divideScalar(distance);
            steering.add(diff);
            total++;
        }
    }

    if (total > 0) {
        steering.divideScalar(total);
        steering.normalize();
        steering.multiplyScalar(bird.maxSpeed);
        steering.sub(bird.velocity);
        if (steering.length() > bird.maxForce) {
            steering.normalize().multiplyScalar(bird.maxForce);
        }
    }

    return steering;
}

// Schwarm-Trennung
function swarmSeparation(bird, neighbors) {
    const perceptionRadius = 30;
    let steering = new THREE.Vector3();
    let total = 0;

    for (let i = 0; i < neighbors.length; i++) {
        const other = neighbors[i];
        if (other === bird) continue;
        
        const distance = bird.position.distanceTo(other.position);
        if (other.swarm !== bird.swarm && 
            distance < perceptionRadius && distance > 0 &&
            isInFieldOfView(bird, other)) {
            let diff = new THREE.Vector3().subVectors(bird.position, other.position);
            diff.normalize();
            diff.divideScalar(distance * 0.5);
            steering.add(diff);
            total++;
        }
    }

    if (total > 0) {
        steering.divideScalar(total);
        steering.normalize();
        steering.multiplyScalar(bird.maxSpeed);
        steering.sub(bird.velocity);
        if (steering.length() > bird.maxForce) {
            steering.normalize().multiplyScalar(bird.maxForce);
        }
    }

    return steering;
}

// Wandvermeidung
function avoidWalls(bird) {
    const wallForce = new THREE.Vector3();
    const wallDistance = 35;
    const wallStrength = 0.8;

    if (bird.position.x > bounds.x - wallDistance) {
        const intensity = (bird.position.x - (bounds.x - wallDistance)) / wallDistance;
        wallForce.x = -intensity * intensity * wallStrength;
    } else if (bird.position.x < -bounds.x + wallDistance) {
        const intensity = (-bounds.x + wallDistance - bird.position.x) / wallDistance;
        wallForce.x = intensity * intensity * wallStrength;
    }

    if (bird.position.y > bounds.y - wallDistance) {
        const intensity = (bird.position.y - (bounds.y - wallDistance)) / wallDistance;
        wallForce.y = -intensity * intensity * wallStrength;
    } else if (bird.position.y < -bounds.y + wallDistance) {
        const intensity = (-bounds.y + wallDistance - bird.position.y) / wallDistance;
        wallForce.y = intensity * intensity * wallStrength;
    }

    if (bird.position.z > bounds.z - wallDistance) {
        const intensity = (bird.position.z - (bounds.z - wallDistance)) / wallDistance;
        wallForce.z = -intensity * intensity * wallStrength;
    } else if (bird.position.z < -bounds.z + wallDistance) {
        const intensity = (-bounds.z + wallDistance - bird.position.z) / wallDistance;
        wallForce.z = intensity * intensity * wallStrength;
    }

    return wallForce;
}

// Hauptalgorithmus
function flock() {
    const alignmentWeight = 1.2;
    const cohesionWeight = 1.0;
    const separationWeight = 1.8;
    const swarmSeparationWeight = 2.2;
    const wallWeight = 3.5;

    for (let i = 0; i < allBirds.length; i++) {
        const bird = allBirds[i];
        
        bird.acceleration.multiplyScalar(0);

        const alignmentForce = align(bird, allBirds);
        alignmentForce.multiplyScalar(alignmentWeight);
        
        const cohesionForce = cohesion(bird, allBirds);
        cohesionForce.multiplyScalar(cohesionWeight);
        
        const separationForce = separation(bird, allBirds);
        separationForce.multiplyScalar(separationWeight);
        
        const swarmSeparationForce = swarmSeparation(bird, allBirds);
        swarmSeparationForce.multiplyScalar(swarmSeparationWeight);
        
        const wallForce = avoidWalls(bird);
        wallForce.multiplyScalar(wallWeight);

        bird.acceleration.add(alignmentForce);
        bird.acceleration.add(cohesionForce);
        bird.acceleration.add(separationForce);
        bird.acceleration.add(swarmSeparationForce);
        bird.acceleration.add(wallForce);

        const targetVelocity = bird.velocity.clone().add(bird.acceleration);
        bird.velocity = lerpVector3(bird.velocity, targetVelocity, bird.smoothingFactor);
        
        const speed = bird.velocity.length();
        if (speed > bird.maxSpeed) {
            bird.velocity.normalize().multiplyScalar(bird.maxSpeed);
        } else if (speed < bird.maxSpeed * 0.7) {
            bird.velocity.normalize().multiplyScalar(bird.maxSpeed * 0.7);
        }

        bird.position.add(bird.velocity);
        updateBirdRotation(bird);

        // Grenzen
        if (bird.position.x > bounds.x) bird.position.x = bounds.x - 1;
        if (bird.position.x < -bounds.x) bird.position.x = -bounds.x + 1;
        if (bird.position.y > bounds.y) bird.position.y = bounds.y - 1;
        if (bird.position.y < -bounds.y) bird.position.y = -bounds.y + 1;
        if (bird.position.z > bounds.z) bird.position.z = bounds.z - 1;
        if (bird.position.z < -bounds.z) bird.position.z = -bounds.z + 1;
    }
}

function animate() {
    requestAnimationFrame(animate);
    flock();
    renderer.render(scene, camera);
}

animate();