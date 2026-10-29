const std = @import("std");
const rl = @import("raylib");

var prng = std.Random.DefaultPrng.init(313);
const random = prng.random();

// exploration params
var epsilon: f32 = 1;
const MAX_EPS = 1.0;
const MIN_EPS = 0.05;
const DECAY_RATE = 5e-4;

// learning params
const LEARNING_RATE = 0.8;
const GAMMA = 0.95;

fn epsilonGreedy() u8 {
    if (random.float(f32) > epsilon) {
        //return max q table
    } else {
        const action = random.intRangeAtMost(u8, 0, 4);
        return action;
    }
}

pub fn choiceAction() u8 {
    const action = random.intRangeAtMost(u8, 0, 4);
    std.debug.print("action: {d}\n", .{action});

    return action;
}
