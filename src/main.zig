const rl = @import("raylib");
const std = @import("std");

const snake = @import("snake/snake.zig");

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
    for (0..3) |_| {
        try snake.addSegment(allocator);
    }

    
    while (!rl.windowShouldClose()) {
        snake.move(snake.down);

        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(.white);

        snake.show();
        rl.drawText("um texto", 190, 200, 20, .light_gray);
    }
}
