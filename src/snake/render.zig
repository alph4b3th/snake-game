const std = @import("std");
const snake = @import("snake.zig");
const rl = @import("raylib");

pub const size: i32 = 10;

pub fn draw_snake(body: std.ArrayList(snake.cell)) void {
    for (body.items) |c| {
        rl.drawRectangle(c.posX, c.posY, size, size, .black);
    }
}
