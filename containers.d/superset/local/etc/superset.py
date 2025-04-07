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

# https://flask-appbuilder.readthedocs.io/en/latest/security.html#authentication-oauth
AUTH_TYPE = AUTH_OAUTH
AUTH_USER_REGISTRATION = True

OAUTH_PROVIDERS = [{
    "name": "google",
    "whitelist": ["@nalca.bio"],
    "icon": "fa-google",
    "token_key": "access_token",
    "remote_app": {
        "api_base_url": "https://www.googleapis.com/oauth2/v2/",
        "client_kwargs": {
            "scope": "email profile",
        },
        "request_token_url": None,
        "access_token_url": "https://accounts.google.com/o/oauth2/token",
        "authorize_url": "https://accounts.google.com/o/oauth2/auth",
        "client_id": os.environ["SUPERSET_OIDC_CLIENT_ID"],
        "client_secret": os.environ["SUPERSET_OIDC_CLIENT_SECRET"],
    },
}]
