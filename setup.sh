#!/bin/bash

# Create directories
mkdir -p host service1 service2

# Create files for the host
cat << EOF > host/host.py
import requests

def main():
    message = "A"
    response1 = requests.post('http://localhost:5000/send_message', json={"message": message})
    print(f"Response from Service 1: {response1.json()['response']}")

if __name__ == "__main__":
    main()
EOF

# Create files for Service 1
cat << EOF > service1/service1.py
from bentoml import BentoService, api, artifacts
from bentoml.adapters import JsonInput, JsonOutput
import requests

@artifacts([])
class Service1(BentoService):

    @api(input=JsonInput(), output=JsonOutput())
    def send_message(self, parsed_json):
        message = parsed_json["message"]
        print(f"Received message: {message}")
        response = requests.post('http://localhost:5001/respond', json={"response": "B"})
        return {"response": "C"}

if __name__ == "__main__":
    from bentoml import serve
    service = Service1()
    serve(service)
EOF

# Create files for Service 2
cat << EOF > service2/service2.py
from bentoml import BentoService, api, artifacts
from bentoml.adapters import JsonInput, JsonOutput

@artifacts([])
class Service2(BentoService):

    @api(input=JsonInput(), output=JsonOutput())
    def respond(self, parsed_json):
        response = parsed_json["response"]
        print(f"Received response: {response}")
        return {"response": response}

if __name__ == "__main__":
    from bentoml import serve
    service = Service2()
    serve(service)
EOF

# Instructions to run the services
echo "To run the host:"
echo "python host/host.py"

echo "To run Service 1:"
echo "bentoml serve service1/service1.py:Service1 --port 5000"

echo "To run Service 2:"
echo "bentoml serve service2/service2.py:Service2 --port 5001"
