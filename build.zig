const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    _ = b.addModule("cpuinfo", .{ .root_source_file = b.path("cpuinfo.zig") });

    const mod = b.createModule(.{
        .root_source_file = b.path("cpuinfo.zig"),
        .target = target,
        .optimize = optimize,
        .link_libc = (@import("builtin").os.tag == .windows),
    });

    const test_step = b.addTest(.{ .root_module = mod });
    b.step("test", "Run library tests").dependOn(&b.addRunArtifact(test_step).step);
}
