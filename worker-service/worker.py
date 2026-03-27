import time
import redis

redis_client = redis.Redis(host="redis", port=6379)

def process_jobs():
    print("Worker started. Waiting for jobs...")

    while True:
        job = redis_client.lpop("job_queue")

        if job:
            print(f"Processing job: {job.decode('utf-8')}")
            time.sleep(3)
            print("Job completed")

        time.sleep(2)

if __name__ == "__main__":
    process_jobs()