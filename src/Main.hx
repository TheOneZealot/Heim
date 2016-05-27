
import luxe.GameConfig;
import luxe.Vector;
import luxe.Input;

typedef Body = {pos:Vector, vel:Vector, mass:Float, size:Float};

class Main extends luxe.Game
{
    var bodies:Array<Body> = [
        {pos: new Vector(256, 256), vel: new Vector(0, 0), mass: 1000, size: 32},
        {pos: new Vector(128, 256), vel: new Vector(0, 0), mass: 1, size: 4}
    ];

    var vel:Vector = new Vector();

    override function config(config:GameConfig)
    {
        config.window.title = 'luxe game';
        config.window.width = 960;
        config.window.height = 640;
        config.window.fullscreen = false;

        return config;
    }

    override function ready()
    {

    }

    override function onkeyup(e:KeyEvent)
    {
        if(e.keycode == Key.escape)
        {
            Luxe.shutdown();
        }
        else if(e.keycode == Key.tab)
        {
            Luxe.showConsole(!Luxe.debug.visible);
        }

    }

    override function update(dt:Float)
    {
        var i = 0;
        for(body1 in bodies)
        {
            body1.pos.add(body1.vel.multiplyScalar(dt));

            for(body2 in bodies)
            {
                if (body1 == body2) continue;
                var deltaPos = Vector.Subtract(body2.pos, body1.pos);
                var force = deltaPos.normalized.multiplyScalar(body1.mass * body2.mass / deltaPos.lengthsq);
                vel.add(force);
                trace("Body" + (i + 1) + " Vx: " + force.x + " Vy: " + force.y);
            }

            Luxe.draw.text({
                immediate: true,
                pos: new Vector(8, 8 + i * 32),
                text: "Body" + (i + 1) + " Vx: " + body1.vel.x + " Vy: " + body1.vel.y
            });

            Luxe.draw.ring({
                immediate: true,
                x: body1.pos.x,
                y: body1.pos.y,
                r: body1.size
            });

            i++;
        }

        vel.add(new Vector(1, 1));
        Luxe.draw.text({
            immediate: true,
            pos: new Vector(8, 40 + i * 32),
            text: "Body" + (i + 1) + " Vx: " + vel.x + " Vy: " + vel.y
        });
    }
}
