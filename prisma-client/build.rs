use std::process::Command;

fn main() {
    println!("cargo:rerun-if-changed=build.rs");
    println!("cargo:rerun-if-changed=../prisma/schema.prisma");
    Command::new("cargo")
        .arg("prisma generate")
        .status()
        .unwrap();
}
