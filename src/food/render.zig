const rl = @import("raylib");
const food = @import("food.zig");
const std = @import("std");

const appleSize = 20;

pub fn show(apple: food.Food) void {

    rl.drawRectangle(apple.posX, apple.posY, appleSize, appleSize, .red);
}
