---
title: "Apache Airflow Note"
date: 2023-11-14T00:00:00+08:00
draft: false
description: ""
type: "post"
tags: []
categories : ["other"]
tags: ["airflow", "ETL"]
---

A tool for task orchestration. Those with basic Linux experience are likely familiar with crontab, but it has limitations, such as the inability to establish complex task dependencies and easily review logs. In such cases, a comprehensive ETL (Extract, Transform, Load) tool is needed. This note briefly documents my learning process and shares the results on [GitHub Repo](https://github.com/shawn1251/StockFlow).

Additionally, as of now, Airflow has evolved to version 2, and there are still many tutorials online for version 1. When learning, it's essential to pay attention to the version. Official documentation can be found [here](https://airflow.apache.org/blog/airflow-two-point-oh-is-here/).

## Features
* Open-source
* User-friendly UI
* Rich plugin ecosystem
* Purely Python-based

## Getting Started

For a quick start, you can use the official Docker Compose setup:
https://airflow.apache.org/docs/apache-airflow/stable/howto/docker-compose/index.html

```bash
curl -LfO 'https://airflow.apache.org/docs/apache-airflow/2.7.3/docker-compose.yaml'
```
Create necessary volumes and set up the Airflow executor:

```bash
mkdir -p ./dags ./logs ./plugins ./config
echo -e "AIRFLOW_UID=$(id -u)" > .env
docker compose up airflow-init
docker compose up
```

## DAG
DAG (Directed Acyclic Graph). In Airflow, a DAG is a definition of a workflow, describing a series of tasks and their dependencies. Each task represents a unit of work that can be any operation executable in Airflow, such as running a Python script, executing an SQL query, or invoking an external API.

### Example
```python
from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.dummy_operator import DummyOperator
from airflow.operators.python_operator import PythonOperator

# Define default parameters
default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2023, 1, 1),
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

def print_hello():
    print("Hello from the PythonOperator task")

# Define DAG
with DAG(
    'simple_dag_example',
    default_args=default_args,
    description='A simple example DAG',
    schedule_interval=timedelta(days=1),  # Run every day
) as dag:

    # Define two tasks; decorators are also available starting from v2
    start_task = DummyOperator(
        task_id='start_task',
        dag=dag,
    )

    python_task = PythonOperator(
        task_id='python_task',
        python_callable=print_hello,
        dag=dag,
    )

    # Define dependencies between tasks; 
    # in this example, python_task runs after start_task
    start_task >> python_task
```

## Scheduler
The scheduler checks the DAGs folder at regular intervals:

1. Checks for any DAGs requiring a DAG Run.
2. Creates scheduled task instances for tasks under DAG Run.

To create a task, place the DAG Python file in the DAGs folder. You can copy and modify examples from the [Airflow official documentation](https://airflow.apache.org/docs/apache-airflow/2.0.0/tutorial.html) or refer to the example in the previous section.

## UI Operations
Once the scheduler has completed the update, we can see our newly added DAGs on the UI. Due to platform constraints, detailed UI operations with numerous images are not suitable here, so instead, here is the [official UI documentation link](https://airflow.apache.org/docs/apache-airflow/stable/ui.html).

Focus on mastering the basics:
* View DAG operation status
* Manually trigger DAG runs
* Review DAG execution logs

