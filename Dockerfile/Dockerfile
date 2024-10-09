# Use the official Python image from the Docker hub
FROM python:3.9

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

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
