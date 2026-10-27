const rl = @import("raylib");
const std = @import("std");

const snake = @import("snake/snake.zig");
const rSnake = @import("snake/render.zig");
const food = @import("food/food.zig");

pub fn main() anyerror!void {
    const screenWidth = 800;
    const screenHeight = 450;
    const fps = 15;

    rl.initWindow(screenWidth, screenHeight, "snake game ai");
    defer rl.closeWindow();

    rl.setTargetFPS(fps);

    var gpa = std.heap.SafeAllocator.init(
        std.heap.page_allocator,
        .{},
    );
    defer _ = gpa.deinit();

    const allocator = gpa.allocator();

    try snake.create(allocator);
    for (1..10) |_| {
        try snake.addSegment(allocator);
    }

    var apple = try food.create(
        256,
        250,
        rSnake.size,
        screenHeight,
        screenWidth,
    );

    while (!rl.windowShouldClose()) {
        if (rl.isKeyDown(.right)) snake.changeDirection(snake.right);
        if (rl.isKeyDown(.left)) snake.changeDirection(snake.left);

        if (rl.isKeyDown(.up)) snake.changeDirection(snake.up);

        if (rl.isKeyDown(.down)) snake.changeDirection(snake.down);

        if (snake.isSelfColision() or snake.isOutofBounds(screenWidth, screenHeight)) {
            std.debug.print("GAME OVeR\n", .{});
            // break;
        }

        if (apple.isColision(snake.positionHead()[0], snake.positionHead()[1])) {
            std.debug.print("APPLEEE\n", .{});
            apple.restart();
        }
        snake.move();
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(.white);

        snake.show();
        apple.show();

        rl.drawText("@alph4b3th", 190, 200, 20, .light_gray);
    }
}
