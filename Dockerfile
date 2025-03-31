# Start from Python 3.11
FROM python:3.11-slim

# Install system dependencies for ODBC and dbt dependencies
RUN apt-get update && \
    apt-get install -y \
    curl \
    gnupg \
    apt-transport-https \
    g++ \
    unixodbc-dev \
    lsb-release \
    git
# Add Microsoft ODBC driver repository
RUN curl -sSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/microsoft.gpg
RUN echo "deb [arch=amd64] https://packages.microsoft.com/debian/12/prod bookworm main" > /etc/apt/sources.list.d/mssql-release.list

# Install ODBC driver
RUN apt-get update && \
    ACCEPT_EULA=Y apt-get install -y msodbcsql17

# Install dbt-core and dbt-synapse
RUN pip install dbt-core==1.9.3 dbt-synapse
RUN pip install pyodbc azure-identity

# Set working directory
WORKDIR /workspace

# Default command
CMD ["bash"]
