# builder stage : 빌드파일 생성
# 생성된 파일과 폴더들은 /usr/src/app/build 로 들어감
FROM node:16-alpine as builder
WORKDIR '/usr/src/app'
COPY package.json .
RUN npm install
COPY ./ ./
RUN npm run build

# run stage : nginx 가동
# build 된 파일들을 nginx 약속된 폴더로 복사
FROM nginx
EXPOSE 80
COPY --from=builder /usr/src/app/build /usr/share/nginx/html


