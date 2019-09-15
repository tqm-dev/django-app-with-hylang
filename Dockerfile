
### Temporal image to build and install packages
FROM python:3.7 as build-python

# Install Python dependencies
WORKDIR /temp
ADD requirements.txt /temp
RUN pip install -r requirements.txt

# Install PayPal sdk
WORKDIR /temp
RUN git clone https://github.com/taqma/Checkout-Python-SDK
WORKDIR /temp/Checkout-Python-SDK
RUN pip install paypal-checkout-serversdk

### Final image
FROM python:3.7-slim

# Copy all scripts
ADD . /app

# Copy installed Python dependencies
COPY --from=build-python /usr/local/lib/python3.7/site-packages/ /usr/local/lib/python3.7/site-packages/
COPY --from=build-python /usr/local/bin/ /usr/local/bin/

WORKDIR /app
