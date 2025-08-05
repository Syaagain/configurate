// Szene, Kamera, Renderer
const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera(75, window.innerWidth/window.innerHeight, 0.1, 1000);
const renderer = new THREE.WebGLRenderer({antialias: true});
renderer.setSize(window.innerWidth, window.innerHeight);
renderer.setClearColor(0x000000); // Schwarzer Hintergrund
document.body.appendChild(renderer.domElement);

camera.position.set(0, 50, 90);
camera.lookAt(0, 0, 0);

// Szenen-Grenzen definieren
const bounds = {
    x: 80,
    y: 60,
    z: 90
};

// Schwarm 1: Ultramarine blaue Vögel
const birdCount1 = 50;
const birds1 = [];
const birdGeometry1 = new THREE.CircleGeometry(1.2, 8);
const birdMaterial1 = new THREE.MeshBasicMaterial({color: 0x120A8F});

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
    bird.velocity.normalize().multiplyScalar(0.8);
    bird.swarm = 1;
    
    // Für gleichmäßigere Bewegung
    bird.previousVelocity = bird.velocity.clone();
    bird.smoothingFactor = 0.85; // Bewegungsglättung
    
    scene.add(bird);
    birds1.push(bird);
}

// Schwarm 2: Ultramarine blaue Vögel
const birdCount2 = 50;
const birds2 = [];
const birdGeometry2 = new THREE.CircleGeometry(1.0, 8);
const birdMaterial2 = new THREE.MeshBasicMaterial({color: 0x120A8F});

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
    bird.velocity.normalize().multiplyScalar(0.8);
    bird.swarm = 2;
    
    bird.previousVelocity = bird.velocity.clone();
    bird.smoothingFactor = 0.85;
    
    scene.add(bird);
    birds2.push(bird);
}

// Schwarm 3: Ultramarine blaue Vögel
const birdCount3 = 50;
const birds3 = [];
const birdGeometry3 = new THREE.CircleGeometry(1.4, 8);
const birdMaterial3 = new THREE.MeshBasicMaterial({color: 0x120A8F});

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
    bird.velocity.normalize().multiplyScalar(0.8);
    bird.swarm = 3;
    
    bird.previousVelocity = bird.velocity.clone();
    bird.smoothingFactor = 0.85;
    
    scene.add(bird);
    birds3.push(bird);
}

const allBirds = [...birds1, ...birds2, ...birds3];

window.addEventListener('resize', () => {
    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();
    renderer.setSize(window.innerWidth, window.innerHeight);
});

// Gleichmäßigere Wandvermeidung
function avoidWalls(bird) {
    const wallForce = new THREE.Vector3();
    const wallDistance = 40; // Noch größerer Abstand für sanftere Reaktion
    const wallStrength = 0.6; // Reduzierte Stärke

    // X-Achse
    if (bird.position.x > bounds.x - wallDistance) {
        const intensity = (bird.position.x - (bounds.x - wallDistance)) / wallDistance;
        const curveStrength = intensity * intensity * wallStrength; // Quadratische Kurve
        wallForce.x = -curveStrength;
    } else if (bird.position.x < -bounds.x + wallDistance) {
        const intensity = (-bounds.x + wallDistance - bird.position.x) / wallDistance;
        const curveStrength = intensity * intensity * wallStrength;
        wallForce.x = curveStrength;
    }

    // Y-Achse
    if (bird.position.y > bounds.y - wallDistance) {
        const intensity = (bird.position.y - (bounds.y - wallDistance)) / wallDistance;
        const curveStrength = intensity * intensity * wallStrength;
        wallForce.y = -curveStrength;
    } else if (bird.position.y < -bounds.y + wallDistance) {
        const intensity = (-bounds.y + wallDistance - bird.position.y) / wallDistance;
        const curveStrength = intensity * intensity * wallStrength;
        wallForce.y = curveStrength;
    }

    // Z-Achse
    if (bird.position.z > bounds.z - wallDistance) {
        const intensity = (bird.position.z - (bounds.z - wallDistance)) / wallDistance;
        const curveStrength = intensity * intensity * wallStrength;
        wallForce.z = -curveStrength;
    } else if (bird.position.z < -bounds.z + wallDistance) {
        const intensity = (-bounds.z + wallDistance - bird.position.z) / wallDistance;
        const curveStrength = intensity * intensity * wallStrength;
        wallForce.z = curveStrength;
    }

    return wallForce;
}

// Gleichmäßigerer Boids-Algorithmus
function flock() {
    const perceptionRadius = 20; 
    const separationRadius = 10; 
    const maxSpeed = 0.6;
    const minSpeed = 0.4; 
    const maxForce = 0.015; 

    // Ausgewogene Gewichtungen
    const alignmentWeight = 1.5; // Erhöht für bessere Synchronisation
    const cohesionWeight = 1.2;
    const separationWeight = 1.5;
    const wallWeight = 3.0;
    const swarmSeparationWeight = 2.0;

    allBirds.forEach(bird => {
        let alignment = new THREE.Vector3();
        let cohesion = new THREE.Vector3();
        let separation = new THREE.Vector3();
        let swarmSeparation = new THREE.Vector3();
        let totalSame = 0;
        let totalSeparation = 0;
        let totalOther = 0;

        // Nachbarn finden
        allBirds.forEach(other => {
            if (other === bird) return;
            
            const distance = bird.position.distanceTo(other.position);
            
            // Gleicher Schwarm
            if (bird.swarm === other.swarm && distance < perceptionRadius && distance > 0) {
                alignment.add(other.velocity);
                cohesion.add(other.position);
                totalSame++;
            }
            
            // Separation von allen
            if (distance < separationRadius && distance > 0) {
                let diff = new THREE.Vector3().subVectors(bird.position, other.position);
                diff.normalize();
                diff.divideScalar(Math.max(distance, 0.1)); // Verhindert Division durch 0
                separation.add(diff);
                totalSeparation++;
            }

            // Schwarm-Trennung
            if (bird.swarm !== other.swarm && distance < perceptionRadius * 1.2 && distance > 0) {
                let diff = new THREE.Vector3().subVectors(bird.position, other.position);
                diff.normalize();
                diff.divideScalar(Math.max(distance * 0.8, 0.1));
                swarmSeparation.add(diff);
                totalOther++;
            }
        });

        let totalForce = new THREE.Vector3();

        // Kräfte berechnen und normalisieren
        if (totalSame > 0) {
            // Alignment
            alignment.divideScalar(totalSame);
            if (alignment.length() > 0) {
                alignment.normalize();
                alignment.multiplyScalar(maxSpeed);
                alignment.sub(bird.velocity);
                alignment.clampLength(0, maxForce);
                alignment.multiplyScalar(alignmentWeight);
                totalForce.add(alignment);
            }

            // Cohesion
            cohesion.divideScalar(totalSame);
            cohesion.sub(bird.position);
            if (cohesion.length() > 0) {
                cohesion.normalize();
                cohesion.multiplyScalar(maxSpeed);
                cohesion.sub(bird.velocity);
                cohesion.clampLength(0, maxForce);
                cohesion.multiplyScalar(cohesionWeight);
                totalForce.add(cohesion);
            }
        }

        if (totalSeparation > 0) {
            separation.divideScalar(totalSeparation);
            if (separation.length() > 0) {
                separation.normalize();
                separation.multiplyScalar(maxSpeed);
                separation.sub(bird.velocity);
                separation.clampLength(0, maxForce);
                separation.multiplyScalar(separationWeight);
                totalForce.add(separation);
            }
        }

        if (totalOther > 0) {
            swarmSeparation.divideScalar(totalOther);
            if (swarmSeparation.length() > 0) {
                swarmSeparation.normalize();
                swarmSeparation.multiplyScalar(maxSpeed);
                swarmSeparation.sub(bird.velocity);
                swarmSeparation.clampLength(0, maxForce);
                swarmSeparation.multiplyScalar(swarmSeparationWeight);
                totalForce.add(swarmSeparation);
            }
        }

        // Wandvermeidung
        const wallForce = avoidWalls(bird);
        wallForce.multiplyScalar(wallWeight);
        totalForce.add(wallForce);

        // Bewegungsglättung anwenden
        const newVelocity = bird.velocity.clone().add(totalForce);
        
        // Geschwindigkeit mit vorheriger Geschwindigkeit mischen für gleichmäßigere Bewegung
        bird.velocity.multiplyScalar(bird.smoothingFactor);
        bird.velocity.add(newVelocity.multiplyScalar(1 - bird.smoothingFactor));
        
        // Geschwindigkeit begrenzen
        const currentSpeed = bird.velocity.length();
        if (currentSpeed < minSpeed) {
            bird.velocity.normalize().multiplyScalar(minSpeed);
        } else if (currentSpeed > maxSpeed) {
            bird.velocity.normalize().multiplyScalar(maxSpeed);
        }

        // Vorherige Geschwindigkeit speichern
        bird.previousVelocity = bird.velocity.clone();
    });
}

function animate() {
    requestAnimationFrame(animate);

    flock();

    allBirds.forEach(bird => {
        bird.position.add(bird.velocity);

        // Sanftere Grenzen-Behandlung
        if (bird.position.x > bounds.x) bird.position.x = bounds.x - 2;
        if (bird.position.x < -bounds.x) bird.position.x = -bounds.x + 2;
        if (bird.position.y > bounds.y) bird.position.y = bounds.y - 2;
        if (bird.position.y < -bounds.y) bird.position.y = -bounds.y + 2;
        if (bird.position.z > bounds.z) bird.position.z = bounds.z - 2;
        if (bird.position.z < -bounds.z) bird.position.z = -bounds.z + 2;
    });

    renderer.render(scene, camera);
}

animate();