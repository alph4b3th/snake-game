const std = @import("std");
const snake = @import("snake.zig");
const rl = @import("raylib");

pub const size: i32 = 10;

pub fn draw_snake(body: std.ArrayList(snake.cell)) void {
    for (body.items, 0..) |c, idx| {
        if (idx >= body.items.len-1) {
            rl.drawRectangle(c.posX, c.posY, size, size, .red);
        } else if (idx == 0) {
            rl.drawRectangle(c.posX, c.posY, size, size, .green);
        } else {
            rl.drawRectangle(c.posX, c.posY, size, size, .black);
        }
    }
}
