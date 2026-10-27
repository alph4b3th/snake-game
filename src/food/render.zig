const rl = @import("raylib");
const food = @import("food.zig");
const std = @import("std");

const appleSize = 10;
pub fn show(apple: food.Food) void {
    std.debug.print("{d} , {d}\n", .{apple.posX, apple.posY});
    rl.drawRectangle(apple.posX, apple.posY, appleSize, appleSize, .yellow);
}
