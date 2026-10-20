const rl = @import("raylib");

pub fn main() anyerror!void {
    const screenWidth = 800;
    const screenHeight = 450;
    const fps = 15;
    const delay_vel: f64 = 0.3; // 500 ms em segundos

    const directions = enum(u2) {
        left,
        right,
        up,
        down,
    };

    const direction = directions.left;

    rl.initWindow(screenWidth, screenHeight, "snake game ai");
    defer rl.closeWindow();

    rl.setTargetFPS(fps);

    var pos: i32 = 250;
    const size: i32 = 10;

    var last_tick = rl.getTime();

    while (!rl.windowShouldClose()) {
        const now = rl.getTime();

        if (now - last_tick >= delay_vel) {
            pos += size;
            last_tick = now;
        }

        rl.beginDrawing();
        defer rl.endDrawing();

        const Position = struct { x: i32, y: i32 };
        var moviment: Position = .{ .x = 190, .y = 200 };

        moviment = switch (direction) {
            .down => Position{ .x = moviment.x, .y = pos },
            .up => Position{ .x = moviment.x, .y = -pos },
            .left => Position{ .x = -pos, .y = moviment.y },
            .right => Position{ .x = pos, .y = moviment.y},
        };

        rl.clearBackground(.white);
        rl.drawRectangle(moviment.x, moviment.y, size, size, .black);
        rl.drawText("um texto", 190, 200, 20, .light_gray);
    }
}
