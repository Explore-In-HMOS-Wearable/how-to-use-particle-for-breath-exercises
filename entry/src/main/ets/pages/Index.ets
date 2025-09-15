@Entry
@Component
struct Index {
  @State isRedPhase: boolean = true;
  @State countdown: number = 6;

  aboutToAppear() {
    this.startCountdown();
  }

  startCountdown() {
    let countdownInterval = setInterval(() => {
      if (this.countdown > 1) {
        this.countdown -= 1;
      } else {
        clearInterval(countdownInterval);
        this.countdown = 0;
        this.startLoop();
      }
    }, 1000);
  }

  startLoop() {
    setInterval(() => {
      this.isRedPhase = !this.isRedPhase;
    }, 2600);
  }

  build() {
    Stack() {
      Particle({
        particles: [
          {
            emitter: {
              particle: {
                type: ParticleType.POINT,
                config: {
                  radius: 1,
                },
                count: 1000,
                lifetime: -1,
                lifetimeRange: 0
              },
              emitRate: 1000,
              shape: ParticleEmitterShape.CIRCLE,
              position: [0, 0]
            },
            color: {
              range: [Color.Pink, Color.Pink],
              updater: {
                type: ParticleUpdater.CURVE,
                config: [
                  {
                    from: Color.Pink,
                    to: Color.Pink,
                    startMillis: 0,
                    endMillis: 2500,
                    curve: this.isRedPhase ? Curve.EaseOut : Curve.EaseIn
                  },
                ]
              }
            },
            acceleration: {
              speed: {
                range: [0, 0],
                updater: {
                  type: ParticleUpdater.RANDOM,
                  config: [1, 1]
                }
              },
              angle: {
                range: [0, 360]
              }
            }
          },
        ]
      })
        .width(300)
        .height(300)
        .disturbanceFields([{
          strength: this.isRedPhase ? 100 : -100,
          shape: DisturbanceFieldShape.CIRCLE,
          size: { width: 200, height: 200 },
          position: { x: 150, y: 150 },
          feather: 0,
          noiseScale: 1,
          noiseFrequency: 1,
          noiseAmplitude: 1
        }])
    }
    .width('100%')
    .height('100%')
    .align(Alignment.Center)
    .backgroundColor(Color.White)
  }
}