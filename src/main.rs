use prisma::{NewClientError, PrismaClient};

#[tokio::main]
async fn main() {
    let client: Result<PrismaClient, NewClientError> = prisma::new_client().await;
}
