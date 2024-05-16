from bentoml import Service, io

svc2 = Service("svc2")

@svc2.api(input=io.JSON(), output=io.JSON())
def respond(input_data):
    response = input_data["response"]
    print(f"Received response: {response}")
    return {"response": response}
