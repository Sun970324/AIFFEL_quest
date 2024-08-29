import numpy as np
import cv2
import json
import requests
# Load the image
image_path = './test.jpeg'
image = cv2.imread(image_path)

# Resize the image to 32x32 pixels (assuming CIFAR-10 model)
image = cv2.resize(image, (32, 32))

# Normalize the image (assuming the model expects pixel values between 0 and 1)
image = image.astype('float32') / 255.0

# Convert the image to the format expected by the model (e.g., 32x32x3)# TensorFlow models typically expect the image shape as [batch_size, height, width, channels]
image = np.expand_dims(image, axis=0)  # Add batch dimension

print(image.shape)  # Should print (1, 32, 32, 3)

# Convert the image to a list
image_list = image.tolist()

# Create the JSON payload
payload = json.dumps({
    "instances": image_list
})
class_names = ["airplane", "automobile", "bird", "cat", "deer", "dog", "frog", "horse", "ship", "truck"]
# Send the POST request to TensorFlow Serving
url = 'http://localhost:8501/v1/models/cifar_best_model:predict'
headers = {"content-type": "application/json"}
response = requests.post(url, data=payload, headers=headers)
output_probabilities = response.json()['predictions'][0]
predicted_index = np.argmax(output_probabilities)
predicted_class = class_names[predicted_index]
print(predicted_class)
# Print the predictionsprint(response.json())