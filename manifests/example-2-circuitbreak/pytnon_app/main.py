from fastapi import FastAPI
import os
import time

app = FastAPI()

@app.get("/sleep")
def sleep():
  sleep_time = int(os.environ.get("SLEEPTIME", 2))
  time.sleep(sleep_time)
  return {"message": "ok"}

@app.get("/ping")
def ping():
  return {"message": "ok"}
