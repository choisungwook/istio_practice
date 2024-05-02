from locust import HttpUser, task, between, TaskSet


class UserBehaviour(TaskSet):
  @task
  def sleep_endpoint(self):
      response = self.client.get("/sleep")
      print("status code: {response.status_code}")

class MyUser(HttpUser):
  wait_time = between(1, 5)
  tasks=[UserBehaviour]
