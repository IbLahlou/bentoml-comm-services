from bentoml import Service, Runner, io
import requests

svc1 = Service("svc1")

@svc1.api(input=io.JSON(), output=io.JSON())
def send_message(input_data):
    message = input_data["message"]
    print(f"Received message: {message}")
    response = requests.post('http://localhost:5001/respond', json={"response": "B"})
    return {"response": "C"}
