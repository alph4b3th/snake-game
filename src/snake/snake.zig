const std = @import("std");
const rl = @import("raylib");
const render = @import("render.zig");

pub const cell = struct { posX: i32, posY: i32 };
pub const delay_vel = 500;

var body: std.ArrayList(cell) = .empty;

pub fn create() !void {
    var gpa = std.heap.SafeAllocator.init(
        std.heap.page_allocator,
        .{},
    );
    // defer _ = gpa.deinit();

    const allocator = gpa.allocator();

    // defer body.deinit(allocator);

    try body.append(allocator, cell{ .posX = 190, .posY = 250 });
}

var last: f64 = undefined;

pub const right = 1;
pub const left = 2;
pub const up = 3;
pub const down = 4;

pub fn move(direction: u8) void {
    const velocity = 0.3;
    const now = rl.getTime();

    if (now - last > velocity) {
        last = now;
        calculatePosHead(direction);
    }
}

fn calculatePosHead(direction: u8) void {
    switch (direction) {
        right => {
            body.items[0].posX += render.size;
        },

        left => {
            body.items[0].posX -= render.size;
        },
        up => {
            body.items[0].posY -= render.size;
        },
        down => {
            body.items[0].posY += render.size;
        },

        else => {},
    }
}

pub fn show() void {
    render.draw_snake(body);
}
