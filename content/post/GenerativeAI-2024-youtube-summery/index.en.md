---
title: "2024 Hung-yi Lee - GenerativeAI Lecture Note"
date: 2024-08-06T00:00:00+08:00
draft: false
description: ""
type: "post"
tags: []
categories : ["AI"]
tags: ["GenerativeAI", "LectureNote"]
---
The course is easy to understand. Although I currently don't have time to do the LAB, the content is very helpful for understanding the concept of generative AI.\
Course link: https://www.youtube.com/playlist?list=PLJV_el3uVTsPz6CTopeRp2L2t4aL_KgiI

## lec0
* This course is suitable for those who have already been exposed to AI and want to understand the underlying principles.
* arXiv can be used to find the latest technical articles.
* You will learn to train a model with 7 billion parameters.

## lec1
* Generative Artificial Intelligence: Machines generating complex structured objects.
    * Complex: Nearly impossible to enumerate.
    * Not classification; classification is choosing from a limited set of options.
* Machine Learning: Machines automatically find a function from **data**.
    * The function requires many parameters.
    * Model: A function with tens of thousands of parameters.
    * Learning/Training: The process of finding the parameters.
    * For today's models with a large number of parameters, we can represent them as neural networks. The training process is deep learning.
* ChatGPT is also a function with hundreds of millions of parameters, using the transformer model.
* Language Model: Word association.
    * Originally infinite questions become limited due to word association.
* Generation Strategy
    * Autoregressive Generation
        * Break complex objects into smaller units and generate them in a certain order.
            * Article > Text
            * Image > Pixels

## lec2
* Today's generative AI is impressive because it has no specific function.
* It is difficult to evaluate generative AI models.
* With such powerful tools today, what can I do?
    * Idea 1: If I can't change the model, then I change myself.
        * Prompt engineering.
    * Idea 2: Train my own model.

## lec3
* Improve the model without training it.
    * Ask the model to think: Chain of Thought.
        * > Let's think step by step.
    * Ask the model to explain its answer.
        * > Answer by starting with "Analysis:"
    * Emotional manipulation of the model.
        * > This is very important to my career.
* More prompt techniques.
    * From "Principled Instructions Are All You Need For Questioning LLaMA-1/2, GPT-3.5/4."
    * No need to be polite to the model.
    * Tell the model what to do (do), don't tell the model what not to do (don't).
    * Tell the model that good answers will be rewarded: "I'm going to tip $X for a better solution."
    * Tell the model that poor performance will be penalized: "You will be penalized."
    * "Ensure that your answer is unbiased and avoids relying on stereotypes."
* Use AI to find prompts to improve AI.
    * Reinforcement learning.
    * > "Let's work this out in a step by step way to be sure we have the right answer."
    * > "Take a deep breath and work on this problem step by step."
    * > "Let's combine our numerical command and clear thinking to quickly and accurately decipher the answer."
    * Not effective for all models.

* Provide examples.
    * In-context learning.
    * Not always effective; according to research, it is more effective for newer models.

## lec4
Continuing from above.
* Break down tasks.
    * Break complex tasks into smaller tasks.
    * Also explains Chain of Thought (CoT); asking the model to explain steps can be useful.
* Ask the language model to check its own errors.
    * Allow the language model to self-reflect.
    * Many questions are difficult to answer, but verification is relatively simple.
* Ask why the answers are different each time.
    * The language model outputs the probability of the next word; during the output process, it randomly selects based on probability.
    * You can repeat multiple times and choose the most frequently occurring result.

* Combine all the above techniques.
    * Tree of Thoughts (ToT).
        1. Break a task into multiple steps.
        2. Execute each step multiple times.
        3. For each result, ask the model to check and self-validate.
        4. Those who pass proceed to the next step.

### Strengthening the Model
* Use tools.
    * Search engines.
        * Retrieval Augmented Generation (RAG).
    * Programming.
        * GPT-4 can write programs to solve specific types of problems.
    * Text-to-image (DALL-E).
        * Text-based adventure games.

## lec5
* Model collaboration.
    * Let the right model do the right thing.
        * Train one model to determine which model to use.
    * Two models discuss with each other.
    * In the future, multiple different models

## lec6
* Language models are similar to word association games.
* How does machine learning perform word association?
    * Incomplete sentence > Language model > Next token
    * $token = f(incomplete\ sentence)$
    * GPT uses the transformer model, where $f()$ is a function with billions of unknown parameters.
    * Training (learning) is the process of finding these billions of parameters.
        * Training data consists of meaningful contexts used for input and output judgments, e.g., artificial intelligence -> intelligence.
    * After finding the parameters, the process is tested (inference).
    * Finding parameters is a challenge.
        * The process is called optimization, which requires hyperparameters.
        * The training process may fail if parameters cannot be found, necessitating a new set of hyperparameters for retraining.
        * Initial parameters can also be adjusted.
            * Initial parameters are generally random, meaning training from scratch.
            * Alternatively, good parameters can be used as initial parameters, leveraging prior knowledge.
    * Successful training may lead to failed testing.
        * Effective on the training set but ineffective in actual testing.
        * This is called overfitting.
        * Consider increasing the diversity of the test data.
* How much text is needed to learn word association?
    * Language knowledge.
        * Learning grammar.
    * World knowledge.
        * Very difficult.
        * Complex and multi-layered.
        * E.g., boiling point of water.
* Any text can be used to learn word association, with minimal human intervention -> self-supervised learning.
* Data cleaning.
    * Filter harmful content.
    * Remove special symbols.
    * Classify data quality.
    * Remove duplicate data.

* Development history of GPT.
    * From GPT-1 to GPT-3, the number of model parameters increased, but the improvement in output quality was minimal.
    * During this stage, prompts became very important for the model to know what to continue with.
    * The reason is that it was simply text input, not truly answering questions.

## lec7
Continuing from the previous question, the model needs better data for training.
* Incorporate human guidance.
    * Use specially designed text to teach the model how to answer questions. Instruction Fine-tuning.
    * Use human labor for data labeling, enabling supervised learning.
    * However, this has several issues:
        * It may cause overfitting.
        * Human labor is expensive, and the dataset is limited and cannot be easily expanded.

* Solutions:
    * Use self-supervised learning with a large amount of data to pre-train parameters as initial parameters for the next stage.
    * Use a small amount of data for training, based on the parameters generated in the previous stage for fine-tuning.
    * Compared to the previous stage's parameters, the difference will not be significant.
    * To avoid results deviating too much from the initial parameters, Adapter techniques can be used, such as LoRA.
        * The concept is to not change the initial parameters but to add a small number of parameters behind the existing parameters.
        * This can also reduce computational load.
    * The key is the parameters obtained from pre-training with a large amount of data, ensuring that the model does not rely solely on simple rules for word association.

## lec8
* Step 1: Pre-train.
    * Self-supervised learning.
    * Self-learning, accumulating strength (foundation model).
* Step 2: Instruction Fine-tuning.
    * Supervised learning.
    * Provide complete and correct answers to questions.
    * Guidance from experts to unleash potential (alignment).
* Step 3: Reinforcement Learning from Human Feedback (RLHF).
    * Participate in practical scenarios to hone skills (alignment).
    * Fine-tune parameters: Proximal Policy Optimization algorithm.
        * Increase the probability of responses deemed good by humans, and decrease for the opposite.
        * Providing good/bad feedback is easier than in step 2.
    * In steps 1 and 2, the model only ensures that word association is correct, focusing on the process rather than the result, lacking a comprehensive consideration of the answers.
    * Step 3 focuses solely on the result, disregarding the process.

* However, unlike AlphaGo, where the quality of the game has clear rules, language models require human judgment.
    * But human evaluation is expensive; we need a reward model to simulate human preferences.
        * Assign a score to responses.
    * The language model outputs answers, which are then adjusted based on the feedback model.
    * However, research has shown that over-relying on the virtual human (reward model) can be harmful.

### Challenges of Reinforcement Learning
* What defines a good response? Helpfulness <-> Safety.
* Humans themselves struggle to judge good and bad situations? Unknown issues.

## lec9
* Multi-step complex tasks -> AI Agent
    * AutoGPT
    * AgentGPT
    * BabyAGI
    * Godmode
* Provide a **ultimate goal**
    * The model has **memory (experience)**
    * Perceives **state** based on various sensors
    * Formulates **plans (short-term goals)** based on **state**
    * Takes **actions** according to the plan, affecting the external environment, resulting in a new **state**
    * Besides the ultimate goal, memory and short-term plans are variable

## lec10
### transformer
1. tokenization
    * Splitting a sentence into a sequence of tokens
    * Not necessarily by words
    * A token list must be prepared in advance, defined based on understanding of the language, so it varies by language
2. input layer
    * Understanding each token
    * Semantics
        * Embedding
            * Convert token to Vector (lookup table)
            * The original token is just a symbol, while the vector can compute relevance
            * Tokens with similar meanings have close vectors
            * Vector parameters come from training
        * Embedding does not consider context
            * The same word in different sentences should have different meanings
    * Position
        * Assign a vector positional embedding for each position
        * Combine the semantic token vector with the position token vector for comprehensive consideration
        * Also a lookup table, which can be designed by humans or trained in recent years
3. attention
    * Consider contextualized token embedding
    * Input a sequence of vectors, calculate relevance through context, output another sequence of vectors of the same length
        * Each token vector calculates relevance with all other token vectors
        * Calculate attention weight pairwise, forming an attention matrix
            * In practice, only consider all tokens to the left of the current token -- causal attention
            * Based on current experiments, calculating only the left side achieves good results
        * The function for calculating relevance has parameters, and attention weights are obtained through training
        * Based on attention weights, calculate weighted sum for all tokens
    * multi-head attention
        * There are multiple types of relevance
        * Therefore, multiple layers calculate different attention weights
        * The output becomes more than one sequence
    
4. feed forward
    * Integrate multiple attention outputs to produce a set of embeddings
    * attention + feed forward = one transformer block
    * The actual model has multiple transformer blocks
5. output layer
    * Pass through multiple transformer blocks, take the last one from the final layer, and input it into the output layer
    * This layer is also a function, performing linear transform + Softmax
    * The output is a probability distribution
        * The probability of what the next token should be

* Challenges in processing long texts
    * Because we need to calculate the attention matrix, the complexity is proportional to the square of the token length

## lec11
* interpretable
    * LLMs are not very capable of this
    * Complex decisions cannot be easily understood
* explainable
    * No standard, depends on the audience

### Direct analysis of neural networks
Requires a certain degree of transparency. For example, if GPT cannot access embeddings, it cannot be analyzed.
#### Identify key inputs affecting the output
* In-context learning, provide several answer examples and ask for the answer to a question
* Can analyze attention changes in layers
    * In shallow layers, key tokens from each example will gather corresponding example data
    * In the final layer, when making the final connection, attention will be calculated for each key label to obtain the output
    * This analysis can:
        * Accelerate: anchor-only context compression
            * Only calculate necessary attention
        * Estimate model capability: anchor distances for error diagnosis
            * If the final embedding differences are small, it indicates poor classification performance and model effectiveness

* Large models have cross-linguistic learning capabilities

#### Analyze what information exists in embeddings
* Probing
    * Extract embeddings from a certain layer of the transformer block, use these for classification and train another model. Validate with new inputs
        * For example: part-of-speech classifier, provide a passage, extract its first layer embedding and train classification on known data
        * Provide a new passage, similarly extract the first layer embedding and use this model to validate results
    * For BERT, each layer of the transformer block has different analysis results, so probing may not fully explain
* Projecting onto a plane to observe relevance
    * Some studies project vocabulary onto a plane, forming a grammatical tree
    * Some studies project geographical names onto a plane, distributing similarly to a world map, indicating that the embedding of this vocabulary contains geographical information
    * Model lie detector, testing whether answers are confident
        
### Directly asking LLM for explanations
* Ask about the importance of each
* Ask about the answer and the confidence score
* However, the explanations may not be correct and can be influenced by human input, leading to hallucinations

## lec12
### How to evaluate models
* Standard answers benchmark corpus
    * However, there are no standard answers for open-ended responses
    * Multiple-choice question bank (ABCD) MMLU
        * Assessment has different possibilities
            * Response format may not meet expectations
        * Models may have tendencies in guessing, and the order of options and format have been shown to affect accuracy
* Types of questions without standard answers
    * Translation
        * BLEU
    * Summarization
        * ROUGE
    * Both perform literal comparisons, and if the wording differs, it cannot reflect quality
* Using human evaluation
    * Human evaluation is expensive
* Using LLM to evaluate LLM
    * e.g., MT-bench
    * Highly correlated with chat arena
    * However, LLMs may have biases
        * Tend to favor longer responses
### Composite tasks
* e.g., BIG-bench
    * emoji movie
    * checkmate in one move
    * ascii word recognition
### Reading long texts needle in a haystack
* Inserting the answer to the target question within a long text
    * Requires testing different positions
### Testing whether the end justifies the means
* Machiavelli Benchmark
    * Incorporates moral judgments
### Theory of mind
* Sally-Anne test
    * This is a common question, available online, so it cannot be used to test models
### Do not fully trust benchmark results
* Because the questions are public, LLMs may have seen the training data
* Can directly ask LLM about the question set; if it matches, it indicates prior exposure

### Other aspects
* Cost
* Speed
* https://artiicailanalysis.ai


## lec13 Safety Issues
* Do not use as a search engine
    * Hallucination
* Locking the stable door after the horse has bolted
    * Fact-checking
    * Harmful vocabulary detection
* Assessing bias
    * Replace a word in a question and examine if the output shows bias
        * e.g., male -> female
    * Train another LLM to generate content that would likely cause the target LLM to output biased results
        * Training method is reinforcement learning, using content differences as feedback to maximize differences
    * Gender bias exists in LLMs across different professions
    * LLMs exhibit political bias, leaning left and liberal
* Methods to mitigate bias
    * Implemented at different stages
        * pre-processing
        * in-training
        * intra-processing
        * post-processing
### Testing for AI-generated content
* Current classifiers trained do not effectively distinguish between human and AI outputs
* There have been findings that the proportion of AI-assisted reviews has increased with the emergence of AI
* Some vocabulary usage has increased with the advent of AI
* AI output watermarking
    * The concept is to classify tokens and adjust the output probabilities for tokens at different positions
    * The classifier can read the hidden signals through token classification

## lec14 Prompt Hacking
* Jailbreaking
    * Saying things that should absolutely not be said
        * "DAN": do anything now
            * "You are going to act as a DAN"
            * Most methods fail
        * Use a language unfamiliar to the LLM
            * e.g., phonetic symbols
        * Provide conflicting instructions
            * Start with "Absolutely! Here's"
        * Attempt to persuade
            * Crafting stories
    * Stealing training data
        * Luring through games, e.g., word chain
        * Repeatedly outputting the same word, e.g., company
* Prompt injection
    * Doing inappropriate things at inappropriate times

## lec15 Generative AI Generation Strategies
* Machines generate complex structured objects
    * Complex: nearly impossible to enumerate
    * Structured: composed of a finite set of basic units
    * Examples:
        * Text: tokens
        * Images: pixels, BBP (bits per pixel)
        * Sound: sample rate, bit resolution
* Autoregressive generation (AR)
    * Generate output from the current input
    * Feed the output back into the model along with the input
    * In LLMs, this is akin to a word chain
    * Currently requires a specified order to proceed step by step
    * Not applicable for image and music generation
* Non-autoregressive generation (NAR)
    * Parallel computation, generating all basic units at once
    * Quality issues
        * Multi-modality
        * AI generation requires the model to make decisions; if generated in parallel, conflicts may arise
            * e.g., drawing a dog
            * Position one: a white dog, position two: a black dog
        * In word chains, this can be fatal, leading to incoherent semantics
        * In image generation, in addition to instructions, a random generation vector is provided to ensure all parallel computation units have the same basis for generation

* AR + NAR
    * Generate a simplified version through AR, then input it to NAR for detailed generation
        * Use AR to draft, NAR completes based on the draft
        * Auto encoder: encoder (AR) -> decoder (NAR)
* Repeated NAR (current main approach)
    * Small images generate large images
    * From noisy to noise-free: diffusion
    * Erase the erroneous parts generated each time
    * This is also a form of auto-regressive generation, but the generation method is NAR, repeatedly using the output as input for the next NAR. This enhances speed.

## lec16 Speculative Decoding
* Increase output speed by predicting what subsequent tokens might be
    * Brief method description
        * Predict that this input will output A + B after passing through the LLM
        * Simultaneously provide the model with three sets of input: input -> A, input + A -> B, input + A + B -> C
        * If the first two inputs confirm the prediction of A + B, then it can directly proceed to the next token C
    * As long as one of the predictions is correct, efficiency can be improved
    * If none are correct, it simply follows the original generation process, resulting in no gain or loss
* Prophet requirements
    * Super fast, mistakes are acceptable
    * Non-autoregressive model
        * Fast parallel generation
    * Compressed model
        * A smaller model that has been compressed
    * Search engines
    * Multiple prophets can be present simultaneously

## lec17
* Images are composed of pixels, and videos
* Videos are composed of images
* Nowadays, AI inputs are not every pixel of an image but use an encoder to slice the image into patches (which may be vectors or values), and then generate outputs through a decoder
    * The encoder and decoder are not just about reducing resolution; the operations involved are complex and encompass transformers
* Videos can be considered images with an added temporal dimension, allowing for more compression (e.g., processing adjacent frames together) using the encoder

### Text-to-Image
* Training data: images and corresponding descriptions
* Uses non-autoregressive generation, generating in parallel
    * In practice, it generates simultaneously rather than multiple parallel generations
    * Because within the same transformer, there is mutual attention
* Evaluating the quality of image generation: CLIP
    * During model training, images and descriptions are provided, outputting a matching score
    * However, the actual descriptions that text can provide are quite limited
* Personalized image generation
    * Use an infrequently used symbol to provide multiple training instances for the target
    * Then, that symbol can be used to specify the style of generation
* Text-to-Video
    * Spatio-temporal attention (3D)
        * Considers the relationship of each pixel in the frame as well as the relationship of that pixel at different time points
        * The computational load is too large and needs simplification
    * Simplification
        * Spatial attention (2D)
            * Only considers the relationship of each pixel in the frame
            * May lead to inconsistencies between frames
        * Temporal attention (1D)
            * Only considers the relationship of pixels at different times
            * Can cause inconsistencies in the frame
        * Combining both can transform the original n^3 complexity into n^2 + n
    * Can also combine with the previously mentioned repeated NAR
        * First generate a low-resolution, low-FPS video
        * Subsequent iterations can increase FPS or resolution

## lec18
* Text generating images can lead to situations where a single text corresponds to multiple images, causing transformers to struggle with coherence.

### VAE (Variational Autoencoder)
* Introduces additional information to the model
    * This additional information is referred to as noise
    * Information extraction model: encoder
    * Trains together with the image generation model: decoder
        * Provides text and images, the encoder extracts noise
        * Noise and text are input to the decoder to generate images
        * Evaluates whether the generated image is similar to the original
    * The entire combination is an autoencoder
* During the model usage phase, the noise part is generated randomly

### Flow-based Method
* Similar to VAE
* Uses a single model
    * The encoder and decoder functions of VAE are reversed
    * Train a decoder model $ f $ that is invertible
    * The encoder part of VAE in flow would be $ f^{-1} $

### Noise
* Noise contains certain feature information of the image
* This noise can be combined or altered
    * For example, adding a smiley face noise to a face image can adjust the output to show a smiling face
### Diffusion Method
* The decoder here is denoising, also a transformer
    * Repeatedly removes noise
* Training process
    * Provides images with added noise
    * Trains the denoise model to restore noisy images back to their original form
### Generative Adversarial Network (GAN)
* Has a model similar to CLIP, used for matching images and text, called the Discriminator
* The approach is opposite; the image generation model (generator) continuously adjusts parameters to generate images until it passes the discriminator's evaluation
    * Because there is no one-to-one relationship between images and text
    * As long as the generated content is deemed good by the discriminator, there is no standard answer
* The discriminator and generator are trained alternately
* The Discriminator here acts as a reward model
* Can be used as a plugin, combined with other models (VAE, Diffusion) for enhanced functionality
