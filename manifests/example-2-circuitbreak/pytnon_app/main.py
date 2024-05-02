from fastapi import FastAPI
import asyncio

app = FastAPI()

@app.get("/sleep")
async def sleep():
  await asyncio.sleep(2)  # Sleep for 1 second
  return {"message": "ok"}
