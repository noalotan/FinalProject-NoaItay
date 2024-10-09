# Use the official Python image from the Docker hub
FROM python:3.10

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install necessary system packages
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    python3-dev \
    build-essential \
    libxml2-dev \
    libxslt1-dev \
    libffi-dev \
    libpq-dev \
    libssl-dev \
    zlib1g-dev

# Create a directory for the app
RUN mkdir -p /opt/status-page
WORKDIR /opt/status-page

# Copy the requirements file and install dependencies
COPY requirements.txt /opt/status-page/
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire app into the container
COPY . /opt/status-page/

# Collect static files
RUN python manage.py collectstatic --noinput

# Expose the port that the app runs on
EXPOSE 8000

# Run the Django application
CMD ["gunicorn", "statuspage.wsgi:application", "--bind", "0.0.0.0:8000"]
