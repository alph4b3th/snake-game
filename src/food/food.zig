const std = @import("std");
const rl = @import("raylib");
const render = @import("render.zig");

const updateTime = 0.5;
var cellSize: u8 = 10;

var height: i32 = undefined;
var width: i32 = undefined;

// var prng = std.Random.DefaultPrng.init(313);
// const random = prng.random();

fn randomPos() [2]i32 {
    const maxX = @divTrunc(width - cellSize, cellSize);
    const maxY = @divTrunc(height - cellSize, cellSize);

    const x = rl.getRandomValue(0, maxY - 1);
    const y = rl.getRandomValue(0, maxX - 1);
    
    return .{ x * cellSize, y * cellSize };
}

fn isOutofBounds(x: i32, y: i32, screenWidth: i32, screenHeight: i32) bool {
    if (x >= (screenWidth) or x <= 0) {
        return true;
    }

    if (y >= (screenHeight) or y <= 0) {
        return true;
    }

    return false;
}

pub const Food = struct {
    posX: i32,
    posY: i32,
    life: f32 = 100,
    isRotten: bool,
    lastUpdate: f64 = undefined,

    pub fn restart(self: *Food) void {
        self.life = 100;
        self.isRotten = false;
        self.posX, self.posY = randomPos();
    }

    pub fn show(self: *Food) void {
        render.show(self.*);
    }

    pub fn update(self: *Food) void {
        const now = rl.getTime();

        if (now - self.lastUpdate > updateTime) {
            self.life -= 0.4;
            self.lastUpdate = now;
        }

        if (self.life <= 0) {
            self.isRotten = true;
        }
    }

    pub fn isColision(self: *Food, bodyX: i32, bodyY: i32) bool {
        return (bodyX == self.posX) and (bodyY == self.posY);
    }
};

pub fn create(posX: i32, posY: i32, cSize: u8, w: i32, h: i32) !Food {
    cellSize = cSize;
    width = w;
    height = h;
    return Food{ .posX = posX, .posY = posY, .isRotten = false, .lastUpdate = undefined, .life = 100 };
}
