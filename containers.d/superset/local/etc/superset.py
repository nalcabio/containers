import os

MAPBOX_API_KEY = os.environ.get("MAPBOX_API_KEY", default="")

SECRET_KEY = os.environ["SECRET_KEY"]

SQLALCHEMY_DATABASE_URI = "postgresql://usuperset:{}@postgres:5432/superset?sslmode=disable&connect_timeout=10".format(
    os.environ["POSTGRES_PASSWORD"],
)
SQLALCHEMY_TRACK_MODIFICATIONS = False

# https://github.com/apache/superset/issues/30977
FEATURE_FLAGS = {
    "ALLOW_ADHOC_SUBQUERY": True
}
