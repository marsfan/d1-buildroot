build-2021-11:
	docker build --target base -t barrowwight/d1-buildroot:2021.11-base .
	docker build --target toolchain -t barrowwight/d1-buildroot:2021.11-toolchain .
	docker build --target prebuilt -t barrowwight/d1-buildroot:2021.11-prebuilt .

build-2021-11.rc2:
	docker build --target base -f Dockerfile.rc2 -t barrowwight/d1-buildroot:2021.11-rc2-base .
	docker build --target toolchain -f Dockerfile.rc2 -t barrowwight/d1-buildroot:2021.11-rc2-toolchain .
	docker build --target prebuilt -f Dockerfile.rc2 -t barrowwight/d1-buildroot:2021.11-rc2-prebuilt .


push-2021-11: build-2021-11
	docker push barrowwight/private:2021-buildroot-2021.11-base
	docker push barrowwight/private:2021-buildroot-2021.11-toolchain
	docker push barrowwight/private:2021-buildroot-2021.11-prebuilt

push-2021-11.rc2: build-2021-11.rc2
	docker push barrowwight/private:2021-buildroot-2021.11-rc2-base
	docker push barrowwight/private:2021-buildroot-2021.11-rc2-toolchain
	docker push barrowwight/private:2021-buildroot-2021.11-rc2-prebuilt
