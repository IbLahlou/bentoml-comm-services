import requests

def main():
    message = "A"
    response1 = requests.post('http://localhost:5000/send_message', json={"message": message})
    print(f"Response from Service 1: {response1.json()['response']}")

if __name__ == "__main__":
    main()
