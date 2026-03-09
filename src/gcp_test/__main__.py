import uvicorn

from gcp_test.app import get_app

def main():
    app = get_app()

    uvicorn.run(
        app,
        host="0.0.0.0",
        port=8080,
        log_level="debug",
    )


if __name__ == "__main__":
    main()