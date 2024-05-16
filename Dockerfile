FROM python:3.9
RUN pip install -r requirements.txt

EXPOSE 5000
EXPOSE 5001

RUN cd service2
RUN bentoml serve service2:svc2 --port 5001 --reload 
RUN cd ..
RUN cd service1
RUN bentoml serve service1:svc1 --port 5000 --reload 

