FROM python:3.13

RUN addgroup --gid 1001 ws-chat && \
    yes | adduser --disabled-password --uid 1001 --ingroup ws-chat ws-chat

ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1

ENV channels_file ./config/channels.json

WORKDIR /home/ws-chat/src
COPY ./requirements.txt ./

RUN pip install -r requirements.txt

USER ws-chat

COPY --chown=ws-chat ./src ./
COPY --chown=ws-chat ./config ./config

HEALTHCHECK --interval=10s --timeout=5s --retries=5 CMD [ "curl", "localhost:8080" ]

CMD ["python" , "__main__.py"]