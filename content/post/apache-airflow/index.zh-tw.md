---
title: "Apache Airflow 筆記"
date: 2023-11-14T00:00:00+08:00
draft: false
description: ""
type: "post"
tags: []
categories : ["other"]
tags: ["airflow", "ETL"]
---

任務調動的工具。有過基礎linux經驗的應該都知道crontab，但他有無法建立複雜任務依賴，簡單調閱日誌等缺點，這時就需要一個完善的ETL工具。本篇筆記簡單記錄我的學習過程，並將成果上傳到[github repo](https://github.com/shawn1251/StockFlow)

另外目前airflow已經發展到v2，而網路上還能找到不少關於v1的教學，所以在學習的時候要注意版本。官方的文章[在此](https://airflow.apache.org/blog/airflow-two-point-oh-is-here/)

## 特點
* 開源
* 友善的UI
* 有豐富的plugin
* 純python


## Getting Started

推薦快速啟動可以使用官方docker compose
https://airflow.apache.org/docs/apache-airflow/stable/howto/docker-compose/index.html
```bash
curl -LfO 'https://airflow.apache.org/docs/apache-airflow/2.7.3/docker-compose.yaml'
```
創建必要volume與設定airflow執行者
```bash
mkdir -p ./dags ./logs ./plugins ./config
echo -e "AIRFLOW_UID=$(id -u)" > .env
```
init與執行
```bash
docker compose up airflow-init
docker compose up
```

## DAG
DAG(Directed Acyclic Graph)有向無環圖。在Airflow中，DAG是一個工作流程的定義，描述了一系列的任務（Tasks）和它們之間的依賴關係。每個任務代表一個工作單元，可以是任何可以在Airflow中執行的操作，例如執行Python腳本、執行SQL查詢、調用外部API等。

### example
```python
from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.dummy_operator import DummyOperator
from airflow.operators.python_operator import PythonOperator

# 定義預設參數
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

# 定義DAG
with DAG(
    'simple_dag_example',
    default_args=default_args,
    description='A simple example DAG',
    schedule_interval=timedelta(days=1),  # 每天執行一次
) as dag:

    # 定義兩個任務，v2開始也能使用decorator
    start_task = DummyOperator(
        task_id='start_task',
        dag=dag,
    )

    python_task = PythonOperator(
        task_id='python_task',
        python_callable=print_hello,
        dag=dag,
    )

    # 定義任務之間的依賴關係，這樣的範例為先執行start_task後再執行python_task
    start_task >> python_task
```

## Scheduler
Scheduler會定時去檢查DAGs的資料夾
1. 檢查是否有任何DAGs需要DAG Run
2. 對DAG Run 下的task建立schedule task instance

所以要建立一個任務最直覺的方式，就是將編寫好的DAG py檔放入DAGs資料夾。可以從airflow的[example](https://airflow.apache.org/docs/apache-airflow/2.0.0/tutorial.html)中複製並修改開始，或直接參考上個section的example

## UI操作
如果scheduler已經完成update，則我們就能在ui介面上看到我們新增的DAG。關於UI的操作說明礙於平台不適合放入過多圖片，因此改提供[官方的UI說明連結](https://airflow.apache.org/docs/apache-airflow/stable/ui.html)。
大家可以朝著最基本的操作熟悉為目標:
* 檢視DAG運作情況
* 手動觸發DAG運作
* 調閱DAG執行log

