FROM python:3.13-slim-bookworm AS build

ENV UV_COMPILE_BYTECODE=1
ENV UV_LINK_MODE=copy
ENV UV_PYTHON_DOWNLOADS=0

# Install UV
COPY --from=ghcr.io/astral-sh/uv:0.6 /uv /bin/uv

WORKDIR /opt/backend

# Install dependencies from pyproject.toml
COPY ./pyproject.toml ./
COPY ./uv.lock ./
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --no-dev --no-install-project --link-mode=copy --no-editable

FROM python:3.13-slim-bookworm AS production

COPY --from=build /opt/backend/.venv /opt/backend/.venv

WORKDIR /opt/backend

# Add application
COPY ./src/gcp_test ./src/gcp_test
COPY ./pyproject.toml ./

ENV PYTHONPATH="/opt/backend/src"
ENV PATH="/opt/backend/scripts:/opt/backend/.venv/bin:${PATH}"
EXPOSE 8080

ENTRYPOINT ["uvicorn", "src.gcp_test.app:get_app", "--host", "0.0.0.0", "--port", "8080"]