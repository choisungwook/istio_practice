from fastapi import FastAPI
import asyncio

app = FastAPI()

@app.get("/sleep")
async def sleep():
  await asyncio.sleep(2)
  return {"message": "ok"}

@app.get("/ping")
async def ping():
  return {"message": "ok"}
