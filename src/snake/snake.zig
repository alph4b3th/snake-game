const std = @import("std");
const rl = @import("raylib");
const render = @import("render.zig");

pub const cell = struct { posX: i32, posY: i32 };
pub const delay_vel = 500;

var body: std.ArrayList(cell) = .empty;

pub fn create(allocator: std.mem.Allocator) !void {
    try addSegment(allocator);
    //    defer body.deinit(allocator);
}

pub fn addSegment(allocator: std.mem.Allocator) !void {
    try body.append(allocator, cell{ .posX = 190, .posY = 250 });
}

var lastMoveTime: f64 = undefined;

pub const right = 1;
pub const left = 2;
pub const up = 3;
pub const down = 4;

var direction: u8 = right;

pub fn changeDirection(d: u8) void {
    direction = d;
}

pub fn move() void {
    const velocity = 0.3;
    const now = rl.getTime();

    if (now - lastMoveTime > velocity) {
        lastMoveTime = now;
        calculatePosBody();
        calculatePosHead();
    }
}

fn calculatePosHead() void {
    const margin = 1;
    switch (direction) {
        right => {
            body.items[0].posX += render.size + margin;
        },

        left => {
            body.items[0].posX -= render.size + margin;
        },
        up => {
            body.items[0].posY -= render.size + margin;
        },
        down => {
            body.items[0].posY += render.size + margin;
        },

        else => {},
    }
}

fn calculatePosBody() void {
    const len = body.items.len;
    var i = len - 1;

    while (i >= 2) : (i -= 1) {
        std.debug.print("{d}\n", .{i});

        if (i == 2) {
            body.items[2] = body.items[1];
            body.items[1] = body.items[0];
            break;
        }

        body.items[i] = body.items[i - 1];
    }

    // var i: usize = 2;

    // body.items[1] = body.items[0];

    // while (i < len) : (i += 1) {
    //     std.debug.print("{d}\n", .{i});

    //     body.items[i] = body.items[i - 1];

    //     //0 => head
    //     //1 => pescoço
    // }
}

pub fn isSelfColision() bool {
    const len = body.items.len;
    var i = len - 1;

    const head = body.items[0];

    while (i >= 1) : (i -= 1) {
        if (body.items[i].posX == head.posX and body.items[i].posY == head.posY) {
            return true;
        }
    }

    return false;
}

pub fn show() void {
    render.draw_snake(body);
}
