package com.ultralytics.ultralytics_yolo;

import android.app.Activity;
import android.content.Context;
import android.util.Size;

import androidx.annotation.NonNull;
import androidx.camera.core.Camera;
import androidx.camera.core.CameraControl;
import androidx.camera.core.CameraSelector;
import androidx.camera.core.ImageAnalysis;
import androidx.camera.core.ImageCapture;
import androidx.camera.core.ImageCaptureException;
import androidx.camera.core.Preview;
import androidx.camera.lifecycle.ProcessCameraProvider;
import androidx.camera.view.PreviewView;
import androidx.core.content.ContextCompat;
import androidx.lifecycle.LifecycleOwner;

import com.google.common.util.concurrent.ListenableFuture;
import com.ultralytics.ultralytics_yolo.predict.Predictor;

import java.io.File;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Objects;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.atomic.AtomicBoolean;


public class CameraPreview {
    public final static Size CAMERA_PREVIEW_SIZE = new Size(640, 480);
    private final Context context;
    private Predictor predictor;
    private ProcessCameraProvider cameraProvider;
    private CameraControl cameraControl;
    private Activity activity;
    private PreviewView mPreviewView;
    private ImageCapture imageCapture;
    private boolean busy = false;
    private boolean deferredProcessing = false;

    public CameraPreview(Context context) {
        this.context = context;
    }

    public void openCamera(int facing, Activity activity, PreviewView mPreviewView, boolean deferredProcessing) {
        this.activity = activity;
        this.mPreviewView = mPreviewView;
        this.deferredProcessing = deferredProcessing;

        final ListenableFuture<ProcessCameraProvider> cameraProviderFuture = ProcessCameraProvider.getInstance(context);
        cameraProviderFuture.addListener(() -> {
            try {
                cameraProvider = cameraProviderFuture.get();
                bindPreview(facing);
            } catch (ExecutionException | InterruptedException e) {
                // No errors need to be handled for this Future.
                // This should never be reached.
            }
        }, ContextCompat.getMainExecutor(context));
    }

    private void bindPreview(int facing) {
        if (!busy) {
            busy = true;

            final boolean isMirrored = (facing == CameraSelector.LENS_FACING_FRONT);

            Preview cameraPreview = new Preview.Builder()
                    .build();

            CameraSelector cameraSelector = new CameraSelector.Builder()
                    .requireLensFacing(facing)
                    .build();

            ImageAnalysis imageAnalysis =
                    new ImageAnalysis.Builder()
                            .setBackpressureStrategy(deferredProcessing ? ImageAnalysis.STRATEGY_BLOCK_PRODUCER : ImageAnalysis.STRATEGY_KEEP_ONLY_LATEST)
                            .build();

            if (deferredProcessing) {
                final ExecutorService executorService = Executors.newSingleThreadExecutor();
                final AtomicBoolean isPredicting = new AtomicBoolean(false);

                imageAnalysis.setAnalyzer(Runnable::run, imageProxy -> {
                    if (isPredicting.get()) {
                        imageProxy.close();
                        return;
                    }

                    isPredicting.set(true);

                    executorService.submit(() -> {
                        try (imageProxy) {
                            predictor.predict(imageProxy, isMirrored);
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            //clear stream for next image
                            isPredicting.set(false);
                        }
                    });
                });
            } else {
                imageAnalysis.setAnalyzer(Runnable::run, imageProxy -> {
                    predictor.predict(imageProxy, isMirrored);
                    //clear stream for next image
                    imageProxy.close();
                });
            }

            // Unbind use cases before rebinding
            cameraProvider.unbindAll();

            imageCapture = new ImageCapture.Builder()
                    .setTargetRotation(activity.getWindowManager().getDefaultDisplay().getRotation())
                    .build();

            // Bind use cases to camera
            Camera camera = cameraProvider.bindToLifecycle((LifecycleOwner) activity, cameraSelector, cameraPreview, imageAnalysis, imageCapture);

            this.cameraControl = camera.getCameraControl();

            cameraPreview.setSurfaceProvider(mPreviewView.getSurfaceProvider());

            this.busy = false;
        }
    }

    private void bindPreviewWithoutInference(int facing) {
        if (!busy) {
            busy = true;

            Preview cameraPreview = new Preview.Builder()
                    .build();

            CameraSelector cameraSelector = new CameraSelector.Builder()
                    .requireLensFacing(facing)
                    .build();

            // Unbind use cases before rebinding
            cameraProvider.unbindAll();

            imageCapture = new ImageCapture.Builder()
                    .setTargetRotation(activity.getWindowManager().getDefaultDisplay().getRotation())
                    .build();

            // Bind use cases to camera
            Camera camera = cameraProvider.bindToLifecycle((LifecycleOwner) activity, cameraSelector, cameraPreview, imageCapture);

            this.cameraControl = camera.getCameraControl();

            cameraPreview.setSurfaceProvider(mPreviewView.getSurfaceProvider());

            this.busy = false;
        }
    }

    public void setFlashlightValue(boolean value) {
        this.cameraControl.enableTorch(value);
    }

    public void setPredictorFrameProcessor(Predictor predictor) {
        this.predictor = predictor;
    }

    public void setCameraFacing(int facing) {
        bindPreview(facing);
    }

    public void setScaleFactor(double factor) {
        cameraControl.setZoomRatio((float) factor);
    }

    public String takePicture() {
        if (imageCapture == null) throw new NullPointerException("No se encontró ImageCapture !!!");

        // Get documents directory (same as Flutter's getApplicationDocumentsDirectory)
        File outputDir = new File(context.getApplicationInfo().dataDir, "app_flutter");

        if (!outputDir.exists()) {
            outputDir.mkdirs();
        }

        // Create timestamped filename: {MD5}_YYYY_MM_DD_HH_MM_SS.jpg
        String timeStamp = new SimpleDateFormat("yyyy_MM_dd_HH_mm_ss", Locale.getDefault()).format(new Date());

        String hashtext = "";
        try {
            MessageDigest m = MessageDigest.getInstance("MD5");
            m.update(timeStamp.getBytes());
            hashtext = new BigInteger(1, m.digest()).toString(16) + "_";
        } catch (NoSuchAlgorithmException nsaex) {
            System.out.println(nsaex.getMessage());
        }

        String finalPhotoPath = hashtext + timeStamp + ".jpg";

        File photoFile = new File(outputDir, finalPhotoPath);

        String storedPhotoPath = photoFile.getAbsolutePath();


        // Create output options
        ImageCapture.OutputFileOptions outputOptions =
                new ImageCapture.OutputFileOptions.Builder(photoFile).build();

        // Capture photo
        imageCapture.takePicture(
                outputOptions,
                ContextCompat.getMainExecutor(context),
                new ImageCapture.OnImageSavedCallback() {
                    @Override
                    public void onImageSaved(@NonNull ImageCapture.OutputFileResults outputFileResults) {
                        System.out.println("Foto tomada exitosamente en: " + Objects.requireNonNull(outputFileResults.getSavedUri()).getPath());

                    }

                    @Override
                    public void onError(@NonNull ImageCaptureException exception) {
                        System.out.println("Algo salió mal al tomar la fotoo. " + exception.getMessage());
                    }
                }
        );

        return storedPhotoPath;
    }

    public void pauseLivePrediction(int facing) {
        bindPreviewWithoutInference(facing);
    }

    public void resumeLivePrediction(int facing) {
        bindPreview(facing);
    }
}
