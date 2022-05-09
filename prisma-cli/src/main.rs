//! Internal `prisma-cli` crate providing access to the Prisma CLI. This is
//! accessible through `cargo prisma <subcommand>`.

fn main() {
    prisma_client_rust_cli::run();
}
